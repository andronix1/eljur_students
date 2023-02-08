import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/errors/failure.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';

abstract class AccountsRepository {
  AccountEntity? get currentAccount;

  Future<Either<Failure, AccountEntity>> fetchCurrentAccount();
  Future<Either<Failure, AccountEntity>> login(AuthInfo authInfo);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, List<AccountEntity>>> getLocalAccounts();
  Future<Either<Failure, void>> deleteAccount(String id);
}
