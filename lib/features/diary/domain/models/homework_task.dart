import 'package:eljur_students/features/diary/domain/models/homework_file_info.dart';

class HomeworkTask {
  final String text;
  final List<HomeworkFileInfo> files;

  HomeworkTask({required this.text, required this.files});
}