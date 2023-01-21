import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecases/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

import '../entities/account_entity.dart';

class LoginParams {
  final AuthInfo authInfo;

  LoginParams({required this.authInfo});
}

class LoginUseCase implements UseCase<AccountEntity, LoginParams> {
  final AccountsRepository accountsRepository;

  LoginUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, AccountEntity>> call(LoginParams params) =>
      accountsRepository.login(params.authInfo);
}
