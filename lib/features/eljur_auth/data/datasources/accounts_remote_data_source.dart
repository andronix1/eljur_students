import 'dart:convert';

import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/core/errors/exceptions/server_exception.dart';
import 'package:eljur_students/features/eljur_auth/domain/entities/account_entity.dart';
import 'package:http/http.dart' as http;

import '../models/account_model.dart';

abstract class AccountsRemoteDataSource {
  Future<AccountModel> authenticate(AuthInfo authInfo);
}

class AuthException implements Exception {}

class AccountsRemoteDataSourceImpl implements AccountsRemoteDataSource {
  final EljurUriFormer eljurUriFormer;

  AccountsRemoteDataSourceImpl({required this.eljurUriFormer});

  @override
  Future<AccountModel> authenticate(AuthInfo authInfo) async {
    final http.Response authRequest;
    try {
      authRequest = await http.get(eljurUriFormer.formUrl(
          'auth', {'login': authInfo.username, 'password': authInfo.password}));
    } catch (e) {
      throw ServerException();
    }
    if (authRequest.statusCode != 200) throw AuthException();
    final tokenInfo = TokenInfoModel.fromJson(
        jsonDecode(authRequest.body)['response']['result']);
    final http.Response userInfoRequest;
    try {
      userInfoRequest =
          await http.get(eljurUriFormer.formUrl('getRules', {}, tokenInfo));
    } catch (e) {
      throw ServerException();
    }
    if (userInfoRequest.statusCode != 200) throw ServerException();
    final userInfo = UserInfoModel.fromApiJson(
        jsonDecode(userInfoRequest.body)['response']['result']);
    return AccountModel(
        authInfo: authInfo, tokenInfo: tokenInfo, userInfo: userInfo);
  }
}
