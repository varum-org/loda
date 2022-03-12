Function flow(functions) {
  final length = functions.length;
  var index = length;
  while (index-- > 0) {
    if (functions[index] is! Function) {
      throw TypeError();
    }
  }
  return (arg) {
    var index = 0;
    var result = length > 0 ? Function.apply(functions[index], [arg]) : arg[0];
    while (++index < length) {
      result = functions[index].call(result);
    }
    return result;
  };
}
