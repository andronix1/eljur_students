import 'package:sandbox/src/domain/entities/account.dart';

abstract class AccountsRepository {
  Future<Account> getCurrentAccount();
  Future<List<Account>> getAccounts();
  Future<Account> addAccount(AuthInfo authInfo);
}
