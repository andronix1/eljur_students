import 'package:eljur_students/core/failure/failure.dart';
import 'package:eljur_students/features/auth/domain/auth_method.dart';
import 'package:eljur_students/features/auth/domain/users_repository.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:event_listener/event_listener.dart';
import 'package:oxidized/oxidized.dart';

class AuthProvider {
  final String currentUserChanged = "currentUserChanged",
      userDeleted = "currentUserDeleted";

  final UsersRepository repository;
  final EventListener eventsListener = EventListener();

  User? _user;
  User? get user => _user;

  AuthProvider({required this.repository});

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
            eventsListener.emit(userDeleted, user);
            return Ok(user);
          }));

  Future<Failable<void>> signOut() async {
    return (await repository.clearDefaultUser()).andThen((p0) {
      _user = null;
      eventsListener.emit(currentUserChanged, null);
      return const Ok(Null);
    });
  }

  Future<Failable<void>> selectUser(UserId userId) =>
      repository.getUser(userId).andThenAsync((user) async {
        repository.setDefaultUser(user.userInfo.userId);
        _user = user;
        eventsListener.emit(currentUserChanged, user);
        return const Ok(Null);
      });

  Future<Failable<User>> auth(AuthMethod authMethod) =>
      repository.auth(authMethod).andThen((user) {
        _user = user;
        eventsListener.emit(currentUserChanged, user);
        return Ok(user);
      });
}
