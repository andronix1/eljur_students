import 'package:eljur_students/core/eljur/api_response.dart';
import 'package:eljur_students/core/eljur/eljur_uri_former.dart';
import 'package:eljur_students/core/eljur/requester.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/core/failure/server_failure.dart';
import 'package:eljur_students/features/diary/data/remote/models/schedule_dto.dart';
import 'package:eljur_students/features/diary/domain/dary_remote.dart';
import 'package:eljur_students/features/diary/domain/models/schedule.dart';
import 'package:oxidized/oxidized.dart';

class DiaryRemoteImpl implements DiaryRemote {
  final Requester requester;
  final EljurUriFormer uriFormer;

  DiaryRemoteImpl({required this.requester, required this.uriFormer});

  String formatDate(DateTime dateTime) => '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}';

  @override
  Future<Failable<Schedule>> getDiary(DateTime after, DateTime before) => ServerFailure.tryCatchAsync(() => requester.getJson(uriFormer.createUri('/getDiary', {'days': '${formatDate(after)}-${formatDate(before)}', 'rings': 'yes'}))
      .andThen((json) => switch (ApiResponse.fromJson(json, (result) => ScheduleDto.fromJson((result['students'] as Map<String, dynamic>).values.first).toSchedule())) {
        ApiError(message: var message) => Err(ApiError(message: message)),
        ApiSuccess(response: var response) => Ok(response)
      }));
}