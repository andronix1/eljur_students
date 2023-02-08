import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

import '../entities/account_entity.dart';

class GetLocalAccountsParams {}

class GetLocalAccountsUseCase
    implements UseCase<List<AccountEntity>, GetLocalAccountsParams> {
  final AccountsRepository accountsRepository;

  GetLocalAccountsUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, List<AccountEntity>>> call(
          GetLocalAccountsParams params) =>
      accountsRepository.getLocalAccounts();
}
