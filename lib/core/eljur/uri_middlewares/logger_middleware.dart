import 'package:eljur_students/core/eljur/requester.dart';

class LoggerMiddleware extends Middleware {
  final bool logUris, logResponses;

  LoggerMiddleware({required this.logUris, required this.logResponses});

  @override
  Uri applyForUri(Uri uri) {
    if (logUris) {
      print("requesting uri: $uri");
    }
    return uri;
  }

  @override
  Map<String, dynamic> applyForBody(Map<String, dynamic> json) {
    if (logResponses) {
      print("got answer: $json");
    }
    return json;
  }
}
