import '../utils/is_nil.dart';
import 'curry.dart';

Function curry5(Function fn) => (a, [b, c, d, e]) {
      call(a, b, c, d, e) => fn(a, b, c, d, e);
      if (isNil(b)) {
        return curry(([b, c, d, e]) => call(a, b, c, d, e), argsLength: 4);
      }
      if (isNil(c)) {
        return curry(([c, d, e]) => call(a, b, c, d, e), argsLength: 3);
      }
      if (isNil(d)) return curry((d, e) => call(a, b, c, d, e));
      if (isNil(e)) return curry((e) => call(a, b, c, d, e), argsLength: 1);
      return call(a, b, c, d, e);
    };
