import 'package:eljur_students/core/failure/failure.dart';
import 'package:oxidized/oxidized.dart';

class CacheFailure implements Failure {
  final dynamic reason;

  CacheFailure({required this.reason});

  static Future<Failable<T>> tryCatchAsync<T extends Object>(Future<Failable<T>> Function () f) async {
    try {
      return await f();
    } catch (e) {
      return Err(CacheFailure(reason: e));
    }
  }
}

class WasNotCached extends Failure {}