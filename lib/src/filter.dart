import 'curry/curry.dart';

Function filter = curry((predicate, entries) {
  var result = null;
  if (entries is List) {
    result = [];
    for (var v in entries) {
      if (predicate(v)) result.add(v);
    }
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => result.addAll(predicate(k, v)));
  } else {
    result = entries;
  }
  return result;
});
