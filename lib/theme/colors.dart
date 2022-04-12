import 'package:filepanel/theme/palettes/color_palette.dart';
import 'package:flutter/cupertino.dart';

import 'convention.dart';

/// semantically separated colors that are referencing [AppPalette]
/// used directly inside the widgets
class AppColors {
  final ColorPalette palette;

  AppColors({required this.palette});

  // ~*~ single colors ~*~

  // ~*~ Text colors ~*~
  Color get textBackgrounded => palette.pick(AppColor.background);

  Color get textRegular => palette.pick(AppColor.strong);

  Color get textWeak => palette.pick(AppColor.inactive);

  Color get textWeakBackgrounded =>
      palette.pick(AppColor.background).withOpacity(0.75);

  Color get textAccent => palette.pick(AppColor.accent);

  Color get textNegative => palette.pick(AppColor.negative);

  Color get textPositive => palette.pick(AppColor.positive);

  Color get textActive => palette.pick(AppColor.active);

  Color get loaderOverlayBackground => palette.pick(AppColor.strong);

  Color get textInactive => palette.pick(AppColor.inactive);

  Color get inactiveDark => palette.pick(AppColor.inactiveDark);

  Color get inactive => palette.pick(AppColor.inactive);

  Color get activeDark => palette.pick(AppColor.activeDark);

  Color get textAccent2 => const Color(0xFF576D8C);

  Color get textFocused => palette.pick(AppColor.active);

  Color get uploaderActiveObfuscation =>
      const Color(0xff4E6B95).withOpacity(0.7);

  Color get backgroundMain => palette.pick(AppColor.background);

  Color get uploaderLoaderColor => const Color(0xffffffff);

  Color get positiveMessageBackgroundLight => const Color(0xffEFFFEF);

  Color get infoMessageBackgroundLight => const Color(0xffFFFBED);

  Color get infoMessageBackground => const Color(0xffFF7B02);

  Color get registrationMethodBackground => const Color(0xFFEFF2F8);

  Color get chevronColor => const Color(0xFFCACACA);

  Color get infoBackgroundColor => const Color(0xFFEDEDED);

  Color get infoBorderColor => const Color(0xFFCACACA);

  Color get successBackgroundColor => const Color(0xFFEDFFF6);

  Color get successBorderColor => const Color(0xFFBEF2D3);

  Color get backgroundDialog => palette.pick(AppColor.strong).withOpacity(0.6);

  Color get grey => const Color(0xFFC5C5C7);

  Color get darkGrey => const Color(0xFF495362);

  Color get lightGrey => const Color(0xFFECECEC);

  Color get diaStepsColor => const Color(0xFFECECEC);

  List<Color> get diaWaitGradient => const [
    Color(0xFFBFDE8F),
    Color(0xFF79B5E6),
    Color(0xFF5D9FF8),
  ];

  List<Color> get accountBackgroundGradient => const [
    Color(0x88FFAF8D),
    Color(0x885B69EB),
  ];

  Color get hoverColor => const Color(0xFFECECEC);

  Color get historyBackground => const Color(0xFFFFFFFF);

  Color get cardActionBackground => const Color(0xFFFFFFFF);

  Color get cardTextColor => const Color(0xFFFFFFFF);

  Color get blueDisabled => const Color(0xFF8796AD);

  Color get infoBannerButtonColor => const Color(0xFFCACACA);

  Color get lightBlue => const Color(0xFFF8FAFF);

  Color get silentBlue => const Color(0xFF244D8C);

  Color get selfieBackground => const Color(0xCC434447);

  Color get greyBlue => const Color(0xFFD7DDE9);

  Color get darkGrey2 => const Color(0xFF495362);
}
