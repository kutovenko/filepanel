import 'dart:ui';
import 'app_theme.dart';
import 'colors.dart';

/// set of strict rules that are affecting UI colors and sizes
class StyleConvention {
  static AppColors get appColors => AppTheme.colors;

  /// font size mapping for local naming convention
  static const Map<FontSize, double> fontSizes = {
    FontSize.tiny: 10.0,
    FontSize.small: 12.0,
    FontSize.base: 14.0,
    FontSize.increased: 16.0,
    FontSize.major: 18,
    FontSize.big: 20.0,
    FontSize.large: 22.0,
    FontSize.extraLarge: 24.0,
    FontSize.huge: 30.0,
  };

  /// font color mapping for local naming convention
  static Map<FontColor, Color> fontColors = {
    FontColor.primary: appColors.textRegular,
    FontColor.focused: appColors.textFocused,
    FontColor.backgrounded: appColors.textBackgrounded,
    FontColor.weak: appColors.textWeak,
    FontColor.inactiveDark: appColors.inactiveDark,
    FontColor.weakBackgrounded: appColors.textWeakBackgrounded,
    FontColor.accent: appColors.textAccent,
    FontColor.negative: appColors.textNegative,
    FontColor.positive: appColors.textPositive,
    FontColor.active: appColors.textActive,
    FontColor.inactive: appColors.textInactive,
    FontColor.accent2: appColors.textAccent2,
    FontColor.inactive2: appColors.blueDisabled
  };

  /// extract size from enum value [FontSize] multiplied by [fontScaleFactor]
  static double pickFontSize(FontSize size) => fontSizes[size]! * AppTheme.fontScaleFactor;

  /// extract color from enum value [FontColor]
  static Color pickFontColor(FontColor color) => fontColors[color]!;
}

enum FontSize {
  tiny,
  small,
  base,
  increased,
  major,
  big,
  large,
  extraLarge,
  huge,
}

enum FontColor {
  primary,
  backgrounded,
  focused,
  weak,
  inactiveDark,
  weakBackgrounded,
  accent,
  negative,
  positive,
  active,
  inactive,
  accent2,
  inactive2
}

enum AppColor {
  background,
  positive,
  negative,
  errorBackground,
  errorBackgroundBorder,
  accent,
  strong,
  active,
  activeLight,
  activeDark,
  inactive,
  inactiveDark,
  inactiveLight,
  progressStart,
  progressEnd
}
