import 'package:eljur_students/core/dynamic_db/dynamic_db_notifier.dart';
import 'package:eljur_students/core/errors/exceptions/cache_exception.dart';
import 'package:eljur_students/core/errors/exceptions/server_exception.dart';
import 'package:eljur_students/core/errors/failures/cache_failure.dart';
import 'package:eljur_students/core/errors/failures/server_failure.dart';
import 'package:eljur_students/features/eljur_auth/data/datasources/accounts_local_data_source.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';
import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

import '../datasources/accounts_remote_data_source.dart';

class AuthFailure extends Failure {}

class AccountsRepositoryImpl implements AccountsRepository {
  final AccountsLocalDataSource localDataSource;
  final AccountsRemoteDataSource remoteDataSource;
  final DynamicDbNotifier notifier;

  AccountEntity? _currentAccount;

  @override
  AccountEntity? get currentAccount => _currentAccount;

  AccountsRepositoryImpl(
      {required this.notifier,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> deleteAccount(String id) async {
    try {
      return Right(await localDataSource.deleteAccountById(id));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> fetchCurrentAccount() async {
    try {
      return Right(_currentAccount = await localDataSource.getCurrentAccount());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<AccountEntity>>> getLocalAccounts() async {
    try {
      return Right(await localDataSource.getAccounts());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> login(AuthInfo authInfo) async {
    try {
      final account = await remoteDataSource.authenticate(authInfo);
      await localDataSource.cacheAccount(account);
      notifier.set(account.userInfo.id);
      return Right(_currentAccount = account);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      _currentAccount = null;
      return Right(await localDataSource.clearCurrentAccount());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
