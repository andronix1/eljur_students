import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/features/auth/domain/models/auth_info.dart';

class AuthInfoMiddleware extends Middleware {
  final AuthInfo authInfo;

  AuthInfoMiddleware({required this.authInfo});

  @override
  Uri applyForUri(Uri uri) {
    return uri.replace(
        queryParameters: {'auth_token': authInfo.token}
          ..addAll(uri.queryParameters));
  }
}
