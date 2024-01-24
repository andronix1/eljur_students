import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';

class AuthMiddleware extends Middleware {
  String? _authToken;

  AuthMiddleware({required AuthProvider provider}) {
    provider.userChanged.subscribe((user) => _authToken = user?.authInfo.token);
  }

  @override
  Uri applyForUri(Uri uri) => uri.replace(
      queryParameters: {if (_authToken != null) 'auth_token': _authToken}
        ..addAll(uri.queryParameters));
}
