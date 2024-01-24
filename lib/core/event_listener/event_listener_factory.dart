import 'package:eljur_students/core/event_listener/event_listener.dart';
import 'package:eljur_students/core/event_listener/id_generator.dart';

class EventListenerFactory {
  final EventIdGenerator generator;

  EventListenerFactory({required this.generator});

  EventListener<T> createDefault<T>() {
    return EventListener(idGenerator: generator);
  }
}
