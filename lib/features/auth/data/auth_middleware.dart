import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';

class AuthMiddleware extends Middleware {
  String? _authToken;

  AuthMiddleware({required AuthProvider provider}) {
    provider.eventsListener.on(provider.currentUserChanged, (user) => 
      _authToken = (user as User?)?.authInfo.token
    );
  }

  @override
  Uri applyForUri(Uri uri) => uri.replace(queryParameters: { 
    if (_authToken != null)
      'auth_token': _authToken
  }..addAll(uri.queryParameters));
}