import 'curry/curry.dart';
import 'package:dartx/dartx.dart';

Function filterIndexed = curry((predicate, entries) {
  var result = null;
  if (entries is List) {
    result = [];
    entries.forEachIndexed((v, i) {
      if (predicate(v, i)) result.add(v);
    });
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => result.addAll(predicate(k, v)));
  } else {
    result = entries;
  }
  return result;
});
