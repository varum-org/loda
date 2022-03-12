import 'utils/has_key.dart';
import 'utils/is_nil.dart';

hasFromArray(path, obj) {
  if (path.length == 0 || isNil(obj)) {
    return false;
  }
  var val = obj;
  var idx = 0;
  while (idx < path.length) {
    if (!isNil(val) && hasKey(path[idx], val)) {
      val = val[path[idx]];
      if (idx == path.length - 1) {
        if (isNil(val)) {
          return false;
        }
      }
      idx += 1;
    } else {
      return false;
    }
  }

  return true;
}
