import 'dart:ui';

import '../convention.dart';
import 'color_palette.dart';

class LightPalette extends ColorPalette {
  @override
  Map<AppColor, Color> get paletteColors => {
        AppColor.accent: const Color(0xff162A43),
        AppColor.background: const Color(0xfff9f9f9),
        AppColor.positive: const Color(0xff33CC66),
        AppColor.negative: const Color(0xffBF1212),
        AppColor.strong: const Color(0xFF162A43),
        AppColor.inactive: const Color(0xffD7DDE9),
        AppColor.inactiveDark: const Color(0xFF666A6F),
        AppColor.active: const Color(0xff225AAC),
        AppColor.activeDark: const Color(0xff002E74),
        AppColor.activeLight: const Color(0xff86AEE7),
        AppColor.inactiveLight: const Color(0xFFEEF4FB),
        AppColor.errorBackground: const Color(0xFFFFEDED),
        AppColor.errorBackgroundBorder: const Color(0xFFF2BEBE),
        AppColor.progressStart: const Color(0xFFFED7C7),
        AppColor.progressEnd: const Color(0xFFB1B6F3)
      };

  @override
  Palette get type => Palette.light;
}
