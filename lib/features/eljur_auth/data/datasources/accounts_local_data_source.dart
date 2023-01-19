import 'package:eljur_students/features/eljur_auth/data/models/account_model.dart';

abstract class AccountsLocalDataSource {
  Future<AccountModel> getCurrentAccount();
  Future<List<AccountModel>> getAccounts();
  Future<AccountModel> deleteAccountById(int id);
  Future<AccountModel> cacheAccount(AccountModel account);
}
