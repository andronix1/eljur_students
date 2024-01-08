import 'package:eljur_students/core/failure/failure.dart';
import 'package:oxidized/oxidized.dart';

class ServerFailure implements Failure {
  final dynamic reason;

  ServerFailure({required this.reason});

  static Future<Failable<T>> tryCatchAsync<T extends Object>(
      Future<Failable<T>> Function() f) async {
    try {
      return await f();
    } catch (e) {
      return Err(ServerFailure(reason: e));
    }
  }
}
