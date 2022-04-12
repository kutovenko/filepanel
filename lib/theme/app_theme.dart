import 'package:filepanel/theme/palettes/light_palette.dart';
import 'package:filepanel/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'convention.dart';
import 'palettes/color_palette.dart';

/// access point for all styling parameters
/// connecting together all theme parts - text styles, sizes and colors
class AppTheme extends ChangeNotifier {
  /// screen width that is being used by design layouts
  static const double _designLayoutWidth = 320.0;

  static final AppTheme _instance = AppTheme._();

  factory AppTheme() => _instance;

  AppTheme._() : _palette = LightPalette() {
    _typography = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.normal,
        height: 1.5,
        decoration: TextDecoration.none,
        color: _palette.pick(AppColor.strong));
  }

  late ColorPalette _palette;

  static ColorPalette get palette => _instance._palette;

  static AppColors get colors => AppColors(palette: palette);

  late final TextStyle _typography;

  static TextStyle get typography => _instance._typography;

  static double fontScaleFactor = 1.0;

  static ThemeData get defaultThemeData => ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      chipTheme: ChipThemeData(
          backgroundColor: AppTheme.colors.lightGrey,
          disabledColor: AppTheme.colors.lightGrey,
          selectedColor: Colors.white,
          secondarySelectedColor: AppTheme.colors.activeDark,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 2,
          labelStyle: AppTheme.typography.small.bold,
          secondaryLabelStyle: AppTheme.typography.small.bold,
          brightness: Brightness.light));

  void changePalette(Palette palette) {
    switch (palette) {
      case Palette.light:
        _palette = LightPalette();
        break;
    }
    notifyListeners();
  }

  /// adjust font scale factor depending on how device screen width is relates to design layout
  /// helps to keep size proportions
  void adjustFontScaleFactorToFitScreen(double screenWidth) {
    fontScaleFactor = (screenWidth / _designLayoutWidth).clamp(0.75, 1.25);
    notifyListeners();
  }
}
