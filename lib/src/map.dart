import 'curry/curry.dart';
import 'utils/is_nil.dart';

Function map = curry((transform, entries) {
  if (isNil(entries)) return null;
  var result = null;
  if (entries is List) {
    result = [];
    for (var v in entries) {
      result.add(transform(v));
    }
  } else if (entries is Map) {
    result = {};
    entries.map((k, v) => result.addAll(transform(k, v)));
  } else {
    result = transform(entries);
  }
  return result;
});
