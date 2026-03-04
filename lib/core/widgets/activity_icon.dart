import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import 'package:flutter/material.dart';

enum AIconSz { sm, md, lg, xl }

class AIcon extends StatelessWidget {
  const AIcon({
    super.key,
    required this.iconKey,
    this.size = AIconSz.md,
    this.bgColor,
    this.borderColor,
    this.iconColor,
  });

  final String iconKey;
  final AIconSz size;
  final Color? bgColor;
  final Color? borderColor;
  final Color? iconColor;

  static const Map<AIconSz, double> _boxSizes = <AIconSz, double>{
    AIconSz.sm: 32,
    AIconSz.md: 44,
    AIconSz.lg: 56,
    AIconSz.xl: 72,
  };

  static const Map<AIconSz, double> _iconSizes = <AIconSz, double>{
    AIconSz.sm: 16,
    AIconSz.md: 22,
    AIconSz.lg: 28,
    AIconSz.xl: 36,
  };

  static const Map<String, IconData> _icons = <String, IconData>{
    'brush': Icons.brush,
    'bed': Icons.bed,
    'food': Icons.restaurant,
    'backpack': Icons.backpack,
    'book': Icons.menu_book,
    'pencil': Icons.edit,
    'sport': Icons.sports_soccer,
    'bath': Icons.bathtub,
    'tv': Icons.tv,
    'game': Icons.sports_esports,
    'art': Icons.palette,
    'music': Icons.music_note,
    'fruit': Icons.apple,
    'home': Icons.home,
    'night': Icons.nights_stay,
    'morning': Icons.wb_sunny,
    'alarm': Icons.alarm,
    'trophy': Icons.emoji_events,
    'target': Icons.gps_fixed,
    'rocket': Icons.rocket_launch,
    'star': Icons.star,
    'clipboard': Icons.assignment,
    'sparkles': Icons.auto_awesome,
  };

  @override
  Widget build(BuildContext context) {
    final AppTone tone = AppColors.activityTone(iconKey);

    return Container(
      width: _boxSizes[size],
      height: _boxSizes[size],
      decoration: BoxDecoration(
        color: bgColor ?? tone.background,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        border: Border.all(
          color: borderColor ?? tone.border,
          width: AppBorderW.base,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        _icons[iconKey] ?? Icons.circle,
        size: _iconSizes[size],
        color: iconColor ?? tone.foreground,
      ),
    );
  }
}
