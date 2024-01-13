import 'dart:io';

import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class UserScopedDatabase {
  final Directory dbDirectory;
  final AuthProvider authProvider;

  Future<Database?> _database = Future.value(null);

  Future<Database> getDatabase() => _database.then((value) {
        if (value == null) {
          throw Exception("cannot access database while null");
        }
        return value;
      });

  String _getDbPathFromId(UserId userId) =>
      join(dbDirectory.path, 'user$userId.db');

  void _onUserChanged(UserId? userId) {
    _database = userId == null
        ? Future.value(null)
        : databaseFactoryIo.openDatabase(_getDbPathFromId(userId));
  }

  UserScopedDatabase({required this.authProvider, required this.dbDirectory}) {
    _onUserChanged(authProvider.user?.userInfo.userId);
    authProvider.eventsListener.on(authProvider.currentUserChanged,
        (user) => _onUserChanged((user as User?)?.userInfo.userId));
    authProvider.eventsListener.on(authProvider.userDeleted, (user) {
      if ((user as User?) != null) {
        File(_getDbPathFromId((user as User).userInfo.userId)).delete();
      }
    });
  }
}
