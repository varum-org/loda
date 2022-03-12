import 'utils/is_numberic.dart';
import 'utils/nth.dart';

selectFromArr(pathAr, obj) {
  var val = obj;
  var idx = 0;
  var p;
  while (idx < pathAr.length) {
    if (val == null) {
      return;
    }
    p = pathAr[idx];
    val = isNumeric(p) ? nth(p, val) : val[p];
    idx += 1;
  }

  return val;
}
