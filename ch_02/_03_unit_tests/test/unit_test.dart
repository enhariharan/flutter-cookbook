import 'package:_03_unit_tests/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Is even', () {
    expect(isEven(2), true);
    expect(isEven(3), false);
  });
}