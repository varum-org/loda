nth(offset, list) {
  final idx = offset < 0 ? list.length + offset : offset;
  return list[idx];
}
