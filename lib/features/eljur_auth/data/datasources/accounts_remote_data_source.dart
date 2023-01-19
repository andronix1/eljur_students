import '../models/account_model.dart';

abstract class AccountsRemoteDataSource {
  Future<AccountModel> authenticate();
  Future<AccountModel> logout();
}
