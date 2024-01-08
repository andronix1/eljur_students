import 'package:eljur_students/core/failure/failure.dart';
import 'package:oxidized/oxidized.dart';

abstract class Middleware {
  Uri applyForUri(Uri uri) => uri;
  Map<String, dynamic> applyForBody(Map<String, dynamic> body) => body;
}

abstract class Requester {
  final List<Middleware> middlewares = [];

  Future<Failable<Map<String, dynamic>>> getJsonWithoutMiddlewares(Uri uri);

  Future<Failable<Map<String, dynamic>>> getJson(Uri uri,
      [List<Middleware>? additionalMiddlewares]) {
    var allMiddlewares = (additionalMiddlewares ?? [])..addAll(middlewares);
    return getJsonWithoutMiddlewares(allMiddlewares.fold(
            uri, (value, element) => element.applyForUri(value)))
        .andThen((json) => Ok(allMiddlewares.fold(json,
            (previousValue, element) => element.applyForBody(previousValue))));
  }
}
