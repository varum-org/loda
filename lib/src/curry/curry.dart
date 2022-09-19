import '../and.dart';
import '../flow.dart';
import '../utils/is_not_nil.dart';
import '../utils/constants.dart';
import 'curry1.dart';
import 'curry2.dart';
import 'curry3.dart';
import 'curry4.dart';
import 'curry5.dart';

Function curry(Function fn, {int argsLength = 2}) {
  assert(argsLength <= 5);
  return <T, E, A, B, C>([T? a, E? b, A? c, B? d, C? e]) {
    hasPlaceholder(value) => value == LodaConstants.placeholder;
    hasFullValue(args) => List.of(args).length == argsLength;
    hasNotPlaceholder(values) => List.of(values).isEmpty;
    valuesNotNull(args) => args.where(isNotNil);
    valuesHasPlaceholder(args) => args.where(hasPlaceholder);
    final args = valuesNotNull([a, b, c, d, e]).toList();
    final isEligible = flow([
      valuesNotNull,
      and([
        flow([hasFullValue]),
        flow([valuesHasPlaceholder, hasNotPlaceholder])
      ])
    ]);
    if (isEligible([a, b, c, d, e])) {
      return Function.apply(fn, args);
    }
    if (1 == argsLength) return curry1(fn)(a);
    if (2 == argsLength) return curry2(fn)(a, b);
    if (3 == argsLength) return curry3(fn)(a, b, c);
    if (4 == argsLength) return curry4(fn)(a, b, c, d);
    if (5 == argsLength) return curry5(fn)(a, b, c, d, e);
  };
}
