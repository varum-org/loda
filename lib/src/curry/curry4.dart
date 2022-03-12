import '../utils/is_nil.dart';
import 'curry.dart';

Function curry4 = (Function fn) => (a, [b, c, d]) {
      final call = (a, b, c, d) => fn(a, b, c, d);
      if (isNil(b)) {
        return curry(([b, c, d]) => call(a, b, c, d), argsLength: 3);
      }
      if (isNil(c)) return curry(([c, d]) => call(a, b, c, d));
      if (isNil(d)) return curry((d) => call(a, b, c, d), argsLength: 1);
      return fn(a, b, c, d);
    };
