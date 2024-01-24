import 'package:eljur_students/core/event_listener/event_listener.dart';
import 'package:eljur_students/core/event_listener/event_listener_factory.dart';
import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/users_repository.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:oxidized/oxidized.dart';

class AuthProvider {
  final UsersRepository repository;
  final EventListener<User> _userDeleted;
  final EventListener<User?> _userChanged;
  EventSubscriber<User> get userDeleted => _userDeleted;
  EventSubscriber<User?> get userChanged => _userChanged;

  User? _user;
  User? get user => _user;

  AuthProvider(
      {required this.repository,
      required EventListenerFactory eventListenerFactory})
      : _userDeleted = eventListenerFactory.createDefault(),
        _userChanged = eventListenerFactory.createDefault();

  Future<Failable<void>> initDefaultUser() =>
      repository.getDefaultUser().andThen((info) {
        if (info is DefaultUserSelected) {
          _user = info.user;
        }
        return const Ok(Null);
      });

  Future<Failable<void>> deleteUser(UserId userId) =>
      repository.getUser(userId).then((result) => result
              .mapAsync((user) => repository
                  .deleteUser(userId)
                  .then((result) => result.map((_) => user)))
              .andThen((user) {
            if (user.isOk()) {
              _userDeleted(user.unwrap());
            }
            return Ok(user);
          }));

  Future<Failable<void>> signOut() async {
    return (await repository.clearDefaultUser()).andThen((p0) {
      _user = null;
      _userChanged(null);
      return const Ok(Null);
    });
  }

  Future<Failable<void>> selectUser(UserId userId) =>
      repository.getUser(userId).andThenAsync((user) async {
        repository.setDefaultUser(user.userInfo.userId);
        _user = user;
        _userChanged(user);
        return const Ok(Null);
      });

  Future<Failable<User>> auth(AuthMethod authMethod) =>
      repository.auth(authMethod).andThen((user) {
        _user = user;
        _userChanged(user);
        return Ok(user);
      });
}
