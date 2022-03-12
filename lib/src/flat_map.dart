import 'curry/curry.dart';
import 'utils/is_nil.dart';

Function flatMap = curry((transform, entries) {
  if (isNil(entries)) return null;
  var result = null;
  if (entries is List) {
    result = [];
    for (var e in entries) {
      result.addAll(e);
    }
  } else {
    result = transform(entries);
  }
  return result;
});
