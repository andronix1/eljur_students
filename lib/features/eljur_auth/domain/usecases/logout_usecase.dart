import 'package:eljur_students/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eljur_students/core/usecase.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';

class LogoutParams {}

class LogoutUseCase implements UseCase<void, LogoutParams> {
  final AccountsRepository accountsRepository;

  LogoutUseCase({required this.accountsRepository});

  @override
  Future<Either<Failure, void>> call(LogoutParams params) =>
      accountsRepository.logout();
}
