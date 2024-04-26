import 'curry/curry.dart';
import 'utils/is_nil.dart';

Function fmap = curry((transform, entries) {
  if (isNil(entries)) return null;
  dynamic result;
  if (entries is List) {
    result = [];
    for (var v in entries) {
      (result as List).add(transform(v));
    }
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => (result as Map).addAll(transform(k, v)));
  } else {
    result = transform(entries);
  }
  return result;
});
