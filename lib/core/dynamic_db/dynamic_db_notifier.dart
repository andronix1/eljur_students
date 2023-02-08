import 'package:flutter/cupertino.dart';

class DynamicDbNotifier extends ChangeNotifier {
  String? _folderName;
  final String mainFolderName;

  String? get folderName => _folderName;

  DynamicDbNotifier({required this.mainFolderName});

  void clear() {
    _folderName = null;
    notifyListeners();
  }

  void set(String name) {
    _folderName = name;
    notifyListeners();
  }
}
