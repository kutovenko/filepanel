import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'convention.dart';

/// App's font configurations
/// use "${fontWeight}${colorAlteration}${size}" pattern for naming
/// [fontWeight] naming is described here https://docs.microsoft.com/en-us/typography/opentype/spec/os2#usweightclass
/// may be omitted if regular [FontWeight.normal] used
/// [colorAlteration] stands for color variants that differs depending on background or UI role, [FontColor]
/// [withSize] describes size variation following the convention of [FontSize]
extension Typografy on TextStyle {
  TextStyle withSize(FontSize size) => copyWith(fontSize: StyleConvention.pickFontSize(size));

  TextStyle withWeight(FontWeight fontWeight) => copyWith(fontWeight: fontWeight);

  TextStyle withColor(FontColor color) => copyWith(color: StyleConvention.pickFontColor(color));

  ///Sizes presets

  TextStyle get tiny => withSize(FontSize.tiny);

  TextStyle get small => withSize(FontSize.small);

  TextStyle get base => withSize(FontSize.base);

  TextStyle get increased => withSize(FontSize.increased);

  TextStyle get major => withSize(FontSize.major);

  TextStyle get big => withSize(FontSize.big);

  TextStyle get large => withSize(FontSize.large);

  TextStyle get extraLarge => withSize(FontSize.extraLarge);

  TextStyle get huge => withSize(FontSize.huge);

  ///Weight presets

  TextStyle get normal => withWeight(FontWeight.normal);

  TextStyle get bold => withWeight(FontWeight.bold);

  TextStyle get semibold => withWeight(FontWeight.w600);

  TextStyle get strong => withWeight(FontWeight.w500);

  TextStyle get regular => withWeight(FontWeight.w400);

  ///Colors presets

  TextStyle get accent => withColor(FontColor.accent);

  TextStyle get accent2 => withColor(FontColor.accent2);

  TextStyle get active => withColor(FontColor.active);

  TextStyle get inactive => withColor(FontColor.inactive);

  TextStyle get inactiveBlue => withColor(FontColor.inactive2);

  TextStyle get inactiveDark => withColor(FontColor.inactiveDark);

  TextStyle get weak => withColor(FontColor.weak);

  TextStyle get backgrounded => withColor(FontColor.backgrounded);

  TextStyle get blue => copyWith(color: AppTheme.colors.activeDark);

  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get cardColor => white;
}
