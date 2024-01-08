import 'package:eljur_students/core/eljur/api_response.dart';
import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/data/remote/auth_info_remote_dto.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';
import 'package:oxidized/oxidized.dart';

class CredentialsAuthMethodFactory {
  final EljurUriFormer eljurUriFormer;
  final Requester requester;

  CredentialsAuthMethodFactory(
      {required this.requester, required this.eljurUriFormer});

  CredentialsAuthMethod withCredentials(String username, String password) =>
      CredentialsAuthMethod(
          eljurUriFormer: eljurUriFormer,
          requester: requester,
          username: username,
          password: password);
}

class CredentialsAuthMethod implements AuthMethod {
  final EljurUriFormer eljurUriFormer;
  final Requester requester;
  final String username, password;

  CredentialsAuthMethod(
      {required this.requester,
      required this.eljurUriFormer,
      required this.username,
      required this.password});

  @override
  Future<Failable<AuthInfo>> getAuthInfo() => requester
      .getJson(eljurUriFormer
          .createUri('/auth', {'login': username, 'password': password}))
      .then((result) => result.andThen((json) {
            var response =
                ApiResponse.fromJson(json, AuthInfoRemoteDto.fromJson);
            if (response is ApiSuccess<AuthInfoRemoteDto>) {
              return Ok(response.response.toAuthInfo());
            } else {
              return Err(response as ApiError);
            }
          }));
}
