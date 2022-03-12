import 'just.dart';

class Nothing {
  bool get isSome => false;

  @override
  String toString() => 'Nothing';

  Nothing map(f) => Nothing();

  Nothing flatMap(f) => Nothing();

  unwrap() => null;

  Just<T> getOrElse<T>(T a) => Just(a);
}
