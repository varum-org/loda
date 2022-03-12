import '../utils/is_nil.dart';
import '../utils/constants.dart';

Function curry2(Function fn) {
  return <T, E>([T? a, E? b]) {
    final args = [a, b].where((x) => !isNil(x)).toList();
    switch (args.length) {
      case 2:
        if (args[0] != LodaConstants.placeholder) {
          return Function.apply(fn, args);
        }
        return (a) => fn(a, args[1]);
      case 1:
        return (b) => fn(args[0], b);
      default:
        throw TypeError();
    }
  };
}
