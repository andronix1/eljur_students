import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecases/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

class DeleteAccountParams {
  final String accountId;

  DeleteAccountParams({required this.accountId});
}

class DeleteAccountUseCase implements UseCase<void, DeleteAccountParams> {
  final AccountsRepository accountsRepository;

  DeleteAccountUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, void>> call(DeleteAccountParams params) =>
      accountsRepository.deleteAccount(params.accountId);
}
