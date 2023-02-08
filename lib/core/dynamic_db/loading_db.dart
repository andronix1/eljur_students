import 'package:eljur_students/core/dynamic_db/db_await_getter.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LoadingDb extends DbAwaitGetter {
  final String dbFilename;

  LoadingDb({required this.dbFilename}) {
    db = null;
    databaseFactoryIo.openDatabase(dbFilename).then((value) {
      db = value;
    });
  }
}
