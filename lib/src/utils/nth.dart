nth(int offset, List list) {
  int idx = offset < 0 ? list.length + offset : offset;
  return list[idx];
}
