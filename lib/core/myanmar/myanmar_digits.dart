/// Converts between Myanmar digits (၀–၉) and the numbers stored in SQLite.
class MyanmarDigits {
  static const _myanmar = '၀၁၂၃၄၅၆၇၈၉';
  static const _latin = '0123456789';

  static String format(num value) {
    final rounded = value == value.roundToDouble();
    final text = rounded ? value.toInt().toString() : value.toString();
    return text.split('').map(_toMyanmar).join();
  }

  static double? parse(String input) {
    final converted = input.split('').map(_toLatin).join();
    final match = RegExp(r'-?\d+(?:\.\d+)?').firstMatch(converted);
    if (match == null) return null;
    return double.tryParse(match.group(0)!);
  }

  static String _toMyanmar(String char) {
    final index = _latin.indexOf(char);
    return index >= 0 ? _myanmar[index] : char;
  }

  static String _toLatin(String char) {
    final index = _myanmar.indexOf(char);
    return index >= 0 ? _latin[index] : char;
  }
}
