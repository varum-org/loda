bool Function(dynamic) and(functions) {
  final length = functions.length;
  var index = length;
  while (index-- > 0) {
    if (functions[index] is! Function) {
      throw TypeError();
    }
  }
  return (arg) {
    var index = 0;
    if (arg == null) {
      throw ArgumentError();
    }
    var result = length > 0 ? Function.apply(functions[index], [arg]) : false;
    while (++index < length) {
      result = result && Function.apply(functions[index], [arg]);
    }
    return result;
  };
}
