import 'curry/curry.dart';
import 'utils/is_nil.dart';
import 'package:dartx/dartx.dart';

Function mapIndexed = curry((transform, entries) {
  if (isNil(entries)) return null;
  var result = null;
  if (entries is List) {
    result = [];
    result.addAll(entries.mapIndexed((i, v) => transform(v, i)));
  } else if (entries is Map) {
    result = {};
    entries.map((k, v) => result.addAll(transform(k, v)));
  } else {
    result = transform(entries);
  }
  return result;
});
