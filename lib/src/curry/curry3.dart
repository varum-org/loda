import '../utils/is_nil.dart';
import 'curry.dart';

Function curry3(Function fn) => (a, [b, c]) {
      call(a, b, c) => fn(a, b, c);

      if (isNil(b)) return curry((b, c) => call(a, b, c));

      if (isNil(c)) return curry((c) => call(a, b, c), argsLength: 1);

      return fn(a, b, c);
    };
