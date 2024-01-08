import 'package:eljur_students/core/eljur/requester.dart';

class EljurBaseMiddleware extends Middleware {
  @override
  Uri applyForUri(Uri uri) {
    return uri.replace(
        queryParameters: {
      'vendor': 'school',
      'devKey': '0c7968cd2b6e14a4eed3c94e593ae9f0'
    }..addAll(uri.queryParameters));
  }
}
