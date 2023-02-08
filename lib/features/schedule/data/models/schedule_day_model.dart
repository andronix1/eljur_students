import 'package:eljur_students/features/schedule/domain/entities/schedule_day.dart';

class TimeModel extends Time {
  TimeModel({required super.hours, required super.minutes});

  factory TimeModel.parse(String str) {
    final split = str.split(':');
    return TimeModel(hours: int.parse(split[0]), minutes: int.parse(split[1]));
  }

  factory TimeModel.fromJson(Map<String, dynamic> json) =>
      TimeModel(hours: json['hours'], minutes: json['minutes']);

  Map<String, dynamic> toJson() => {'hours': hours, 'minutes': minutes};
}

class FileModel extends File {
  FileModel({required super.fileName, required super.link});

  factory FileModel.fromApiJson(Map<String, dynamic> json) =>
      FileModel(fileName: json['filename'], link: json['link']);

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      FileModel(fileName: json['fileName'], link: json['link']);

  Map<String, dynamic> toJson() => {'fileName': fileName, 'link': link};
}

class AssessmentModel extends Assessment {
  AssessmentModel({required super.value, required super.comment});

  factory AssessmentModel.fromApiJson(Map<String, dynamic> json) {
    return AssessmentModel(
        value: json['value'],
        comment: json['comment'] == '' ? null : json['comment']);
  }

  factory AssessmentModel.fromJson(Map<String, dynamic> json) =>
      AssessmentModel(value: json['value'], comment: json['comment']);

  Map<String, dynamic> toJson() => {'value': value, 'comment': comment};
}

class HomeworkModel extends Homework {
  HomeworkModel(
      {required super.value, required super.individual, required super.files});
  factory HomeworkModel.fromApiJson(
      Map<String, dynamic> json, List<FileModel> files) {
    return HomeworkModel(
        value: json['value'], individual: json['individual'], files: files);
  }

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => HomeworkModel(
      value: json['value'],
      individual: json['individual'],
      files: (json['files'] as List<Map<String, dynamic>>)
          .map((e) => FileModel.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        'value': value,
        'individual': individual,
        'files': files.map((e) => (e as FileModel).toJson()).toList()
      };
}

class LessonModel extends Lesson {
  LessonModel(
      {required super.number,
      required super.name,
      required super.room,
      required super.teacher,
      required super.startTime,
      required super.endTime,
      required super.assessments,
      required super.homeworks});

  factory LessonModel.fromApiJson(Map<String, dynamic> json) {
    final Map<int, List<FileModel>> files = {};
    (json['files'] as List<dynamic>?)?.forEach(((e) {
      final int toId = e['toId'.toLowerCase()];
      if (!files.containsKey(toId)) files.addAll({toId: []});
      files[toId]!.add(FileModel.fromApiJson(e));
    }));
    return LessonModel(
        number: int.parse(json['num']),
        name: json['name'],
        room: json['room'],
        teacher: json['teacher'],
        startTime: TimeModel.parse(json['startTime'.toLowerCase()]),
        endTime: TimeModel.parse(json['endTime'.toLowerCase()]),
        assessments: (json['assessments'] as List<dynamic>?)
                ?.map(((e) => AssessmentModel.fromApiJson(e)))
                .toList() ??
            [],
        homeworks: (json['homework'] as Map<String, dynamic>?)
                ?.entries
                .map((e) => HomeworkModel.fromApiJson(
                    e.value, files[e.value['id']] ?? []))
                .toList() ??
            []);
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
      number: json['number'],
      name: json['name'],
      room: json['room'],
      teacher: json['teacher'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      assessments: (json['assessments'] as List<Map<String, dynamic>>)
          .map((e) => AssessmentModel.fromJson(e))
          .toList(),
      homeworks: (json['homework'] as List<Map<String, dynamic>>)
          .map((e) => HomeworkModel.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'room': room,
        'teacher': teacher,
        'startTime': (startTime as TimeModel).toJson(),
        'endTime': (endTime as TimeModel).toJson(),
        'assessments':
            assessments.map((e) => (e as AssessmentModel).toJson()).toList(),
        'homeworks':
            homeworks.map((e) => (e as HomeworkModel).toJson()).toList()
      };
}

class ScheduleDayModel extends ScheduleDay {
  ScheduleDayModel({required super.dateTime, required super.items});

  factory ScheduleDayModel.fromApiJson(Map<String, dynamic> json) {
    return ScheduleDayModel(
        dateTime: DateTime.parse(json['name']),
        items: json['items'] is List<dynamic>
            ? []
            : (json['items'] as Map<String, dynamic>)
                .values
                .map((e) => LessonModel.fromApiJson(e))
                .toList());
  }

  factory ScheduleDayModel.fromJson(Map<String, dynamic> json) =>
      ScheduleDayModel(
          dateTime: DateTime.parse(json['dateTime']),
          items: (json['items'] as List<Map<String, dynamic>>)
              .map((e) => LessonModel.fromApiJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toIso8601String(),
        'items': items.map((e) => (e as LessonModel).toJson()).toList()
      };
}
