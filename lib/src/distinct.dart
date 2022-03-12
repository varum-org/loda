import 'filter_index.dart';
import 'package:dartx/dartx.dart';

Function distinct = (entries) {
  var result = null;
  if (entries is List) {
    result = [];
    result = entries.filterIndexed((v, i) => entries.indexOf(v) == i);
  } else if (entries is Set) {
    result = [];
    entries.forEach((e) {
      if (!result.any((x) => x == e)) result.add(e);
    });
  } else {
    result = entries;
  }
  return result;
};
