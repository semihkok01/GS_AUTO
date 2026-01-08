import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColors {
  // Light
  static Color get lightPrimary => Color(0xFF366b00);
  static Color get lightOnPrimary => Color(0xFFffffff);
  static Color get lightPrimaryContainer => Color(0xFFb5f47c);
  static Color get lightOnPrimaryContainer => Color(0xFF0b2000);
  static Color get lightSecondary => Color(0xFF57624a);
  static Color get lightOnSecondary => Color(0xFFffffff);
  static Color get lightSecondaryContainer => Color(0xFFdbe7c9);
  static Color get lightOnSecondaryContainer => Color(0xFF141e0b);
  static Color get lightTertiary => Color(0xFF386664);
  static Color get lightOnTertiary => Color(0xFFffffff);
  static Color get lightTertiaryContainer => Color(0xFFbbece9);
  static Color get lightOnTertiaryContainer => Color(0xFF00201f);
  static Color get lightError => Color(0xFFba1b1b);
  static Color get lightErrorContainer => Color(0xFFffdad4);
  static Color get lightOnError => Color(0xFFffffff);
  static Color get lightOnErrorContainer => Color(0xFF410001);
  static Color get lightBackground => Color(0xFFfdfcf5);
  static Color get lightOnBackground => Color(0xFF1a1c17);
  static Color get lightSurface => Color(0xFFfdfcf5);
  static Color get lightOnSurface => Color(0xFF1a1c17);
  static Color get lightSurfaceVariant => Color(0xFFe0e4d5);
  static Color get lightOnSurfaceVariant => Color(0xFF44483e);
  static Color get lightOutline => Color(0xFF74796c);
  static Color get lightInverseOnSurface => Color(0xFFf1f1e9);
  static Color get lightInverseSurface => Color(0xFF30312d);

  // Dark
  static Color get darkPrimary => Color(0xFF9ad763);
  static Color get darkOnPrimary => Color(0xFF183800);
  static Color get darkPrimaryContainer => Color(0xFF275100);
  static Color get darkOnPrimaryContainer => Color(0xFFb5f47c);
  static Color get darkSecondary => Color(0xFFbecbad);
  static Color get darkOnSecondary => Color(0xFF29341f);
  static Color get darkSecondaryContainer => Color(0xFF3f4a34);
  static Color get darkOnSecondaryContainer => Color(0xFFdbe7c9);
  static Color get darkTertiary => Color(0xFFa0cfcd);
  static Color get darkOnTertiary => Color(0xFF003736);
  static Color get darkTertiaryContainer => Color(0xFF1e4e4c);
  static Color get darkOnTertiaryContainer => Color(0xFFbbece9);
  static Color get darkError => Color(0xFFffb4a9);
  static Color get darkErrorContainer => Color(0xFF930006);
  static Color get darkOnError => Color(0xFF680003);
  static Color get darkOnErrorContainer => Color(0xFFffdad4);
  static Color get darkBackground => Color(0xFF1a1c17);
  static Color get darkOnBackground => Color(0xFFe3e3db);
  static Color get darkSurface => Color(0xFF1a1c17);
  static Color get darkOnSurface => Color(0xFFe3e3db);
  static Color get darkSurfaceVariant => Color(0xFF44483e);
  static Color get darkOnSurfaceVariant => Color(0xFFc4c8ba);
  static Color get darkOutline => Color(0xFF8e9286);
  static Color get darkInverseOnSurface => Color(0xFF1a1c17);
  static Color get darkInverseSurface => Color(0xFFe3e3db);

// General
  static Color get seed => Color(0xFF96d35f);
  static Color get error => Color(0xFFba1b1b);

  static Color get lightSurface2 => Color(0xFFFFFFFF);
  static Color get darkSurface2 => Color(0xFF000000);
}
