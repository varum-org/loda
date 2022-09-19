import 'curry/curry.dart';
import 'utils/is_nil.dart';
import 'package:dartx/dartx.dart';

Function mapIndexed = curry((transform, entries) {
  if (isNil(entries)) return null;
  dynamic result;
  if (entries is List) {
    result = [];
    (result as List).addAll(entries.mapIndexed((i, v) => transform(v, i)));
  } else if (entries is Map) {
    result = {};
    entries.forEach((k, v) => (result as Map).addAll(transform(k, v)));
  } else {
    result = transform(entries);
  }
  return result;
});
