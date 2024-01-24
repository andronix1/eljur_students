import 'dart:io';

import 'package:eljur_students/features/auth/domain/auth_provider.dart';
import 'package:eljur_students/features/auth/domain/models/user.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class CurrentUserDatabase {
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

  CurrentUserDatabase({required this.authProvider, required this.dbDirectory}) {
    _onUserChanged(authProvider.user?.userInfo.userId);
    authProvider.userChanged
        .subscribe((user) => _onUserChanged(user?.userInfo.userId));
    authProvider.userDeleted.subscribe((user) {
      File(_getDbPathFromId(user.userInfo.userId)).delete();
    });
  }
}
