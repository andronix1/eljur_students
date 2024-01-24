import 'package:eljur_students/core/event_listener/id_generator.dart';

class EventTimestampIdGenerator implements EventIdGenerator {
  @override
  int generateId() => DateTime.now().microsecondsSinceEpoch;
}
