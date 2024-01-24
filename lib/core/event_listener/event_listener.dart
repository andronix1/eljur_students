import 'package:eljur_students/core/event_listener/id_generator.dart';

class EventSubscriber<T> {
  final Map<int, Function(T)> _callbacks = {};
  final EventIdGenerator idGenerator;

  EventSubscriber({required this.idGenerator});

  int subscribe(Function(T) callback) {
    int id = idGenerator.generateId();
    _callbacks.addAll({id: callback});
    return id;
  }

  void unsubscribe(int id) {
    if (_callbacks.containsKey(id)) {
      _callbacks.remove(id);
    }
  }
}

class EventListener<T> extends EventSubscriber<T> {
  EventListener({required super.idGenerator});

  void call(T arg) {
    _callbacks.forEach((id, callback) => callback(arg));
  }
}
