import '../../../app/router.dart';
import '../widgets/scale_in.dart';
import '../widgets/page_entrance.dart';
import 'package:flutter/material.dart';
import '../widgets/child_scaffold.dart';
import '../widgets/child_navigation.dart';
import '../widgets/animated_star_row.dart';
import '../widgets/child_page_header.dart';
import '../widgets/child_surface_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../domain/models/child_models.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/activity_icon.dart';
import '../../data/mock/child_mock_repository.dart';
import '../../../core/widgets/app_progress_bar.dart';

class AchPg extends StatelessWidget {
  const AchPg({super.key});

  @override
  Widget build(BuildContext context) {
    final ChildMockRepository repo = ChildMockRepository.instance;
    final AchievementProgress achievement =
        repo.achievements;

    return CScaf(
      currentRoute: AppRoutes.achievements,
      child: PgIn(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.s16,
            AppSpace.s12,
            AppSpace.s16,
            AppSpace.s16,
          ),
          children: <Widget>[
            PgHead(onBack: () => popOrGoDay(context), title: 'Mis Logros'),
            const SizedBox(height: AppSpace.s16),
            ScIn(
              begin: 0,
              duration: AppMotion.scaleSpring,
              curve: AppMotion.elasticOut,
              child: SizedBox(
                width: AppSize.alarmIconCircle,
                height: AppSize.alarmIconCircle,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.rewardSoft,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.rewardBorder,
                        width: AppBorderW.active,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.emoji_events,
                      size: AppSize.iconXl,
                      color: AppColors.reward,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Text(
              achievement.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.title24,
            ),
            const SizedBox(height: AppSpace.s4),
            Text(
              repo.streakLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.color(
                AppTextStyles.label14,
                AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            StarRow(
              total: achievement.weekStarsTotal,
              filled: achievement.weekStarsFilled,
              size: AppSize.star,
              baseDurationMs: AppMotion.starBaseMs,
              staggerMs: AppMotion.starStaggerMs,
            ),
            const SizedBox(height: AppSpace.s16),
            Text('Medallas Ganadas', style: AppTextStyles.body16),
            const SizedBox(height: AppSpace.s8),
            GridView.builder(
              itemCount: achievement.medals.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppGrid.cols3,
                crossAxisSpacing: AppSpace.s8,
                mainAxisSpacing: AppSpace.s8,
                childAspectRatio: AppGrid.medalAspect,
              ),
              itemBuilder: (BuildContext context, int index) {
                final AchievementMedal medal = achievement.medals[index];
                final AppTone tone = AppColors.medalTone(medal.toneKey);
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(
                    milliseconds:
                        AppMotion.itemBaseMs +
                        (index * AppMotion.medalStaggerMs),
                  ),
                  curve: AppMotion.easeOut,
                  builder: (BuildContext context, double value, Widget? child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * AppOffset.listEntryY),
                        child: child,
                      ),
                    );
                  },
                  child: BoxCard(
                    color: tone.background,
                    radius: AppRadius.r12,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.s8,
                      vertical: AppSpace.s8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AIcon(
                          iconKey: medal.iconKey,
                          size: AIconSz.md,
                          bgColor: tone.background,
                          borderColor: tone.border,
                          iconColor: tone.foreground,
                        ),
                        const SizedBox(height: AppSpace.s8),
                        Text(
                          medal.label,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.color(
                            AppTextStyles.label13,
                            tone.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpace.s12),
            BoxCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Siguiente Medalla', style: AppTextStyles.label14),
                  const SizedBox(height: AppSpace.s4),
                  Text(
                    achievement.nextMedalName,
                    style: AppTextStyles.size(AppTextStyles.title22, 18),
                  ),
                  const SizedBox(height: AppSpace.s8),
                  PBar(value: achievement.percent, color: AppColors.primary),
                  const SizedBox(height: AppSpace.s8),
                  Text(
                    '${achievement.current}/${achievement.target}',
                    style: AppTextStyles.label13,
                  ),
                  const SizedBox(height: AppSpace.s4),
                  Text(
                    'Solo faltan ${achievement.target - achievement.current}',
                    style: AppTextStyles.label13,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.s16),
            Btn(
              label: 'Volver',
              variant: BtnVar.secondary,
              onPressed: () => popOrGoDay(context),
            ),
          ],
        ),
      ),
    );
  }
}
