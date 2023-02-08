class Time {
  final int hours, minutes;

  Time({required this.hours, required this.minutes});

  @override
  String toString() =>
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

class File {
  final String fileName;
  final String link;

  File({required this.fileName, required this.link});
}

class Assessment {
  final String value;
  final String? comment;

  Assessment({required this.value, this.comment});
}

class Homework {
  final String value;
  final bool individual;
  final List<File> files;

  Homework(
      {required this.value, required this.individual, required this.files});
}

class Lesson {
  final int number;
  final String name, room, teacher;
  final Time startTime, endTime;
  final List<Assessment> assessments;
  final List<Homework> homeworks;

  Lesson(
      {required this.number,
      required this.name,
      required this.room,
      required this.teacher,
      required this.startTime,
      required this.endTime,
      required this.assessments,
      required this.homeworks});
}

class ScheduleDay {
  final DateTime dateTime;
  final List<Lesson> items;

  ScheduleDay({required this.dateTime, required this.items});
}
