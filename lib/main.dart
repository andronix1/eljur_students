import 'package:eljur_students/app.dart';
import 'package:eljur_students/dependency_injection.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
