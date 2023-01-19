import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecases/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

import '../entities/account_entity.dart';

class DeleteAccountParams {
  final int accountId;

  DeleteAccountParams(this.accountId);
}

class DeleteAccountUseCase
    implements UseCase<AccountEntity, DeleteAccountParams> {
  final AccountsRepository accountsRepository;

  DeleteAccountUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, AccountEntity>> call(DeleteAccountParams params) =>
      accountsRepository.deleteAccount(params.accountId);
}
