import 'package:flutter/material.dart';

class AppTone {
  const AppTone({
    required this.foreground,
    required this.background,
    required this.border,
  });

  final Color foreground;
  final Color background;
  final Color border;
}

class AppColors {
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F9);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color transparent = Color(0x00000000);
  static const Color scrim = Color(0x66000000);

  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryHover = Color(0xFF2563EB);
  static const Color primarySoft = Color(0xFFDBEAFE);
  static const Color primarySoftBorder = Color(0xFFBFDBFE);
  static const Color primaryShadow = Color(0x333B82F6);

  static const Color success = Color(0xFF22C55E);
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color successSoftBorder = Color(0xFF86EFAC);
  static const Color successStrong = Color(0xFF16A34A);

  static const Color reward = Color(0xFFFACC15);
  static const Color rewardSoft = Color(0xFFFEF3C7);
  static const Color rewardBorder = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  static const AppTone tonePrimary = AppTone(
    foreground: primary,
    background: primarySoft,
    border: primarySoftBorder,
  );

  static const AppTone toneReward = AppTone(
    foreground: reward,
    background: rewardSoft,
    border: rewardBorder,
  );

  static const AppTone toneOrange = AppTone(
    foreground: Color(0xFFEA580C),
    background: Color(0xFFFFEDD5),
    border: Color(0xFFFED7AA),
  );

  static const AppTone toneDanger = AppTone(
    foreground: Color(0xFFDC2626),
    background: Color(0xFFFEE2E2),
    border: Color(0xFFFECACA),
  );

  static const AppTone toneViolet = AppTone(
    foreground: Color(0xFF7C3AED),
    background: Color(0xFFEDE9FE),
    border: Color(0xFFEDE9FE),
  );

  static AppTone medalTone(String toneKey) {
    if (toneKey == 'orange') return toneOrange;
    if (toneKey == 'violet') return toneViolet;
    return toneDanger;
  }

  static AppTone activityTone(String iconKey) {
    if (iconKey == 'alarm') return toneOrange;
    if (iconKey == 'star' || iconKey == 'trophy') return toneReward;
    if (iconKey == 'target') return toneDanger;
    return tonePrimary;
  }
}
