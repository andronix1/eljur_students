import 'package:oxidized/oxidized.dart';

abstract class Failure {}

typedef Failable<T extends Object> = Result<T, Failure>;
