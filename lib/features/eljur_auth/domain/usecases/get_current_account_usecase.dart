import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecases/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

import '../entities/account_entity.dart';

class GetCurrentAccountParams {}

class GetCurrentAccountUseCase
    implements UseCase<AccountEntity, GetCurrentAccountParams> {
  final AccountsRepository accountsRepository;

  GetCurrentAccountUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, AccountEntity>> call(GetCurrentAccountParams params) =>
      accountsRepository.getCurrentAccount();
}
