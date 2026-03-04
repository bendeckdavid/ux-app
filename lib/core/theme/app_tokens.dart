import 'app_colors.dart';
import 'package:flutter/material.dart';

class AppSpace {
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
}

class AppRadius {
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;
}

class AppBorderW {
  static const double base = 2;
  static const double active = 3;
  static const double emphasis = 4;
}

class AppSize {
  static const double progressBarH = 15;
  static const double bottomNavH = 80;
  static const double buttonDefaultH = 48;
  static const double buttonKidH = 52;
  static const double buttonSmH = 40;
  static const double buttonLgH = 56;
  static const double buttonIconH = 44;
  static const double iconSm = 13;
  static const double iconMd = 18;
  static const double iconLg = 20;
  static const double iconXl = 44;
  static const double iconCheckLarge = 38;
  static const double heroBadge = 96;
  static const double heroBadgeIcon = 52;
  static const double heroStar = 98;
  static const double checkAction = 74;
  static const double alarmIconCircle = 92;
  static const double taskCheckBadge = 22;
  static const double star = 32;
}

class AppMotion {
  static const Duration tap = Duration(milliseconds: 110);
  static const Duration pageIn = Duration(milliseconds: 320);
  static const Duration overlay = Duration(milliseconds: 220);
  static const Duration scaleSpring = Duration(milliseconds: 500);
  static const Duration alarmBounce = Duration(milliseconds: 900);
  static const Duration activeChevron = Duration(milliseconds: 1500);
  static const Duration switcher = Duration(milliseconds: 250);
  static const int starBaseMs = 240;
  static const int starStaggerMs = 80;
  static const int itemBaseMs = 280;
  static const int itemStaggerMs = 60;
  static const int medalStaggerMs = 70;
  static const double tapScale = 0.97;
  static const double tapStrongScale = 0.92;
  static const double scaleBegin = 0.92;
  static const double overlayScaleBegin = 0.9;
  static const double disabledOpacity = 0.6;

  static const Curve easeOut = Curves.easeOut;
  static const Curve easeOutBack = Curves.easeOutBack;
  static const Curve elasticOut = Curves.elasticOut;
}

class AppBlur {
  static const double overlaySigma = 6;
}

class AppOffset {
  static const double pageEntryY = 12;
  static const double listEntryY = 10;
  static const double iconBounceY = -8;
  static const double activeChevronX = 4;
}

class AppShadow {
  static const List<BoxShadow> activeCard = <BoxShadow>[
    BoxShadow(
      color: AppColors.primaryShadow,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}

class AppGrid {
  static const int cols3 = 3;
  static const double medalAspect = 0.95;
}
