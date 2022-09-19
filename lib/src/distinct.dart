import 'package:dartx/dartx.dart';

dynamic distinct(entries) {
  dynamic result;
  if (entries is List) {
    result = [];
    result = entries.filterIndexed((v, i) => entries.indexOf(v) == i);
  } else if (entries is Set) {
    result = {};
    for (var e in entries) {
      if (!(result as Set).any((x) => x == e)) result.add(e);
    }
  } else {
    result = entries;
  }
  return result;
}
