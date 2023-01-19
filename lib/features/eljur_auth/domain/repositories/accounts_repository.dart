import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/errors/failure.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';

abstract class AccountsRepository {
  Future<Either<Failure, AccountEntity>> getCurrentAccount();
  Future<Either<Failure, AccountEntity>> login(AuthInfo authInfo);
  Future<Either<Failure, AccountEntity>> logout();
  Future<Either<Failure, List<AccountEntity>>> getLocalAccounts();
  Future<Either<Failure, AccountEntity>> deleteAccount(int id);
}
