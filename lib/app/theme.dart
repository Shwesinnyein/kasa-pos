import 'package:flutter/material.dart';

class KasaColors {
  static Color brown = const Color(0xFF6B4423);
  static const brownDark = Color(0xFF4E3119);
  static const background = Color(0xFFF6F1EA);
  static const card = Color(0xFFFFFCF8);
  static const ink = Color(0xFF2C241B);
  static const muted = Color(0xFF7A6A5C);
  static const line = Color(0xFFE6DDD2);
  static const danger = Color(0xFFC62828);
  static const online = Color(0xFF2E7D32);
}

const themePalette = <String, Color>{
  'brown': Color(0xFF6B4423),
  'green': Color(0xFF2E7D32),
  'blue': Color(0xFF1565C0),
  'plum': Color(0xFF6A1B9A),
};

ThemeData buildKasaTheme({Color? seed, Brightness brightness = Brightness.light}) {
  const family = 'NotoSansMyanmar';
  final accent = seed ?? KasaColors.brown;
  KasaColors.brown = accent;
  final dark = brightness == Brightness.dark;
  final card = dark ? const Color(0xFF2C2622) : Colors.white;
  final ink = dark ? const Color(0xFFF6F1EA) : KasaColors.ink;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: family,
    scaffoldBackgroundColor: dark ? const Color(0xFF171412) : KasaColors.background,
    cardColor: card,
    colorScheme: ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      surface: dark ? card : KasaColors.card,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamily: family, bodyColor: ink, displayColor: ink),
    appBarTheme: AppBarTheme(
      backgroundColor: accent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.white),
    ),
  );
}
