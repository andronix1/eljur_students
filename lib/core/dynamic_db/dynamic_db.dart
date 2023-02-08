import 'package:eljur_students/core/dynamic_db/db_await_getter.dart';
import 'package:eljur_students/core/dynamic_db/dynamic_db_notifier.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class DynamicDb extends DbAwaitGetter {
  final DynamicDbNotifier notifier;
  final String dbFilename;

  DynamicDb({required this.notifier, required this.dbFilename}) {
    notifier.addListener(() {
      db = null;
      if (notifier.folderName == null) return;
      databaseFactoryIo
          .openDatabase(
              join(notifier.mainFolderName, notifier.folderName, dbFilename))
          .then((value) {
        db = value;
      });
    });
  }
}
