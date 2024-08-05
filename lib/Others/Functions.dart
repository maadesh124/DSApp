bool isNumber(String s) {
  if (s.isEmpty) {
    return false;
  }
  final number = double.tryParse(s);
  return number != null;
}