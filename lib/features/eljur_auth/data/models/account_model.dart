import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  AccountModel(
      {required super.authInfo,
      required super.tokenInfo,
      required super.userInfo});
}
