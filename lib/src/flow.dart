Function flow(List<Function> functions) {
  final length = functions.length;
  return (arg) {
    var index = 0;
    var result = length > 0 ? Function.apply(functions[index], [arg]) : arg[0];
    while (++index < length) {
      result = functions[index](result);
    }
    return result;
  };
}
