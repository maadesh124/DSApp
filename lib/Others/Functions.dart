bool isNumber(String s) {
  if (s.isEmpty) {
    return false;
  }
  final number = double.tryParse(s);
  return number != null;
}

void cprint(Object object)
{
  print('\na\nb\nc\nd************$object***********\nx\ny\nz\nz');
}