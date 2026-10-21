import 'package:flutter_test/flutter_test.dart';
import 'package:kasa_pos/core/myanmar/myanmar_digits.dart';

void main() {
  test('Myanmar quantity ၃ ထုပ် is stored as 3', () {
    expect(MyanmarDigits.parse('၃'), 3);
    expect(MyanmarDigits.parse('၃ ထုပ်'), 3);
    expect(MyanmarDigits.parse('၁၅၀၀'), 1500);
  });

  test('stored amounts display as Myanmar digits', () {
    expect(MyanmarDigits.format(3), '၃');
    expect(MyanmarDigits.format(4500), '၄၅၀၀');
  });
}
