import 'curry/curry.dart';

Function filter = curry((predicate, entries) {
  dynamic result;
  if (entries is List) {
    result = [];
    for (var v in entries) {
      if (predicate(v)) (result as List).add(v);
    }
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => (result as Map).addAll(predicate(k, v)));
  } else {
    result = entries;
  }
  return result;
});
