import 'package:sembast/sembast.dart';

class DbAwaitGetter {
  Database? db;

  Future<Database> get database async {
    await Future.doWhile(() => Future.delayed(Duration.zero).then((_) {
          return db == null;
        }));
    return db!;
  }
}
