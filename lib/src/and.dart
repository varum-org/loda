bool Function(dynamic) and(List<Function> functions) {
  final length = functions.length;
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
