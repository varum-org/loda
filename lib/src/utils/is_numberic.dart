bool isNumeric(String? source) {
  if (source == null) {
    return false;
  }
  return double.tryParse(source) != null;
}
