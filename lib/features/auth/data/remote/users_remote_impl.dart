import 'package:eljur_students/core/eljur/api_response.dart';
import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/core/eljur/uri_middlewares/auth_info_middleware.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/data/remote/user_info_remote_dto.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:eljur_students/features/auth/domain/users_remote.dart';
import 'package:oxidized/oxidized.dart';

class UsersRemoteImpl implements UsersRemote {
  final EljurUriFormer eljurUriFormer;
  final Requester requester;

  UsersRemoteImpl({required this.requester, required this.eljurUriFormer});

  @override
  Future<Failable<User>> getUser(AuthMethod authMethod) =>
      authMethod.getAuthInfo().andThenAsync((authInfo) => requester.getJson(
              eljurUriFormer.createUri('/getRules'), [
            AuthInfoMiddleware(authInfo: authInfo)
          ]).then((result) => result.andThen((json) {
                var response =
                    ApiResponse.fromJson(json, UserInfoRemoteDto.fromJson);
                if (response is ApiSuccess<UserInfoRemoteDto>) {
                  return Ok(User(
                      userInfo: response.response.toUserInfo(),
                      authInfo: authInfo));
                } else {
                  return Err(response as ApiError);
                }
              })));
}
