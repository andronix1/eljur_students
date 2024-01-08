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

  Future<Failable<void>> deleteUser(UserId userId) =>
      repository.getUser(userId).then((result) => result
              .mapAsync((user) => repository
                  .deleteUser(userId)
                  .then((result) => result.map((_) => user)))
              .andThen((user) {
            eventsListener.emit(userDeleted, user);
            return Ok(user);
          }));

  void signOut() {
    _user = null;
    eventsListener.emit(currentUserChanged, null);
  }

  Future<Failable<void>> selectUser(UserId userId) =>
      repository.getUser(userId).then((result) {
        return result.fold((user) {
          _user = user;
          print('USER ${user.userInfo.userId}');
          eventsListener.emit(currentUserChanged, user);
          return user;
        }, (failure) => failure);
      });

  Future<Failable<User>> auth(AuthMethod authMethod) =>
      repository.auth(authMethod).andThen((user) {
        _user = user;
        eventsListener.emit(currentUserChanged, user);
        return Ok(user);
      });
}
