import 'package:dio/dio.dart';
import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:oxidized/oxidized.dart';

class DioRequester extends Requester {
  final Dio dio;

  DioRequester({required this.dio}) {
    dio.options.validateStatus = (_) => true;
  }

  @override
  Future<Failable<Map<String, dynamic>>> getJsonWithoutMiddlewares(Uri uri) =>
      dio.get(uri.toString()).then((response) => Ok(response.data));
}
