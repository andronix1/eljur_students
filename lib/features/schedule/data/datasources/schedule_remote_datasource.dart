import 'dart:convert';

import 'package:eljur_students/core/eljur_uri_former.dart';
import 'package:eljur_students/core/errors/exceptions/server_exception.dart';
import 'package:eljur_students/dependency_injection.dart';
import 'package:eljur_students/features/eljur_auth/domain/repositories/accounts_repository.dart';
import 'package:eljur_students/features/schedule/data/models/schedule_day_model.dart';
import 'package:http/http.dart' as http;

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleDayModel>> getSchedule(DateTime start, DateTime end);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final EljurUriFormer eljurUriFormer;

  ScheduleRemoteDataSourceImpl({required this.eljurUriFormer});

  String _dateTimeToString(DateTime val) =>
      '${val.year}${val.month.toString().padLeft(2, '0')}${val.day.toString().padLeft(2, '0')}';

  @override
  Future<List<ScheduleDayModel>> getSchedule(
      DateTime start, DateTime end) async {
    try {
      final currentAccount = locator<AccountsRepository>().currentAccount!;
      final http.Response response = await http.get(
        eljurUriFormer.formUrl(
            'getDiary',
            {
              'rings': 'yes',
              'days': '${_dateTimeToString(start)}-${_dateTimeToString(end)}'
            },
            currentAccount.tokenInfo),
      );
      if (response.statusCode != 200) throw ServerException();
      var days = (jsonDecode(response.body))['response']['result']['students']
          [currentAccount.userInfo.id]['days'];
      return (days as Map<String, dynamic>)
          .values
          .map((e) => ScheduleDayModel.fromApiJson(e))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
