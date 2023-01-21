import 'package:eljur_students/core/errors/exceptions/cache_exception.dart';
import 'package:eljur_students/features/eljur_auth/data/models/account_model.dart';
import 'package:sembast/sembast.dart';

abstract class AccountsLocalDataSource {
  Future<AccountModel> getCurrentAccount();
  Future<List<AccountModel>> getAccounts();
  Future<void> deleteAccountById(String id);
  Future<void> cacheAccount(AccountModel account);
}

class AccountsLocalDataSourceImpl implements AccountsLocalDataSource {
  final Database database;
  final StoreRef accountsStore = stringMapStoreFactory.store('accounts');
  final StoreRef currentAccountStore =
      stringMapStoreFactory.store('currentAccount');

  AccountsLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheAccount(AccountModel account) =>
      accountsStore.record(account.userInfo.id).put(database, account.toJson());

  @override
  Future<void> deleteAccountById(String id) =>
      accountsStore.record(id).delete(database);

  @override
  Future<List<AccountModel>> getAccounts() async =>
      (await accountsStore.find(database, finder: Finder()))
          .map((e) => AccountModel.fromJson(e.value as Map<String, dynamic>))
          .toList();

  @override
  Future<AccountModel> getCurrentAccount() async {
    final obj = await currentAccountStore.record('current').get(database);
    if (obj == null) throw CacheException();
    final account = await accountsStore.record(obj as String).get(database);
    if (account == null) throw CacheException();
    return AccountModel.fromJson(account as Map<String, dynamic>);
  }
}
