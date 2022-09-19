import 'curry/curry.dart';
import 'package:dartx/dartx.dart';

Function filterIndexed = curry((predicate, entries) {
  dynamic result;
  if (entries is List) {
    result = [];
    entries.forEachIndexed((v, i) {
      if (predicate(v, i)) (result as List).add(v);
    });
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => (result as Map).addAll(predicate(k, v)));
  } else {
    result = entries;
  }
  return result;
});
