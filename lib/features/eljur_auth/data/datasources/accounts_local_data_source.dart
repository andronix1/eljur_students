import 'package:eljur_students/core/dynamic_db/loading_db.dart';
import 'package:eljur_students/core/errors/exceptions/cache_exception.dart';
import 'package:eljur_students/features/eljur_auth/data/models/account_model.dart';
import 'package:sembast/sembast.dart';

abstract class AccountsLocalDataSource {
  Future<AccountModel> getCurrentAccount();
  Future<List<AccountModel>> getAccounts();
  Future<void> deleteAccountById(String id);
  Future<void> cacheAccount(AccountModel account);
  Future<void> clearCurrentAccount();
}

class AccountsLocalDataSourceImpl implements AccountsLocalDataSource {
  final LoadingDb database;
  final StoreRef accountsStore = stringMapStoreFactory.store('accounts');
  final StoreRef currentAccountStore =
      stringMapStoreFactory.store('currentAccount');

  AccountsLocalDataSourceImpl({required this.database});

  @override
  Future<void> cacheAccount(AccountModel account) async {
    await accountsStore
        .record(account.userInfo.id)
        .put(await database.database, account.toJson());
    await currentAccountStore
        .record('current')
        .put(await database.database, account.userInfo.id);
  }

  @override
  Future<void> deleteAccountById(String id) async =>
      await accountsStore.record(id).delete(await database.database);

  @override
  Future<List<AccountModel>> getAccounts() async =>
      (await accountsStore.find(await database.database, finder: Finder()))
          .map((e) => AccountModel.fromJson(e.value as Map<String, dynamic>))
          .toList();

  @override
  Future<AccountModel> getCurrentAccount() async {
    final obj = await currentAccountStore
        .record('current')
        .get(await database.database);
    if (obj == null) throw CacheException();
    final account =
        await accountsStore.record(obj as String).get(await database.database);
    if (account == null) throw CacheException();
    return AccountModel.fromJson(account as Map<String, dynamic>);
  }

  @override
  Future<void> clearCurrentAccount() async => await currentAccountStore
      .record('current')
      .delete(await database.database);
}
