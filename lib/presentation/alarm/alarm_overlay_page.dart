import 'dart:ui';
import '../../../app/router.dart';
import '../widgets/scale_in.dart';
import 'package:flutter/material.dart';
import '../widgets/child_note_card.dart';
import '../widgets/child_navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/tap_scale.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_text_styles.dart';

class AlmOvPg extends StatefulWidget {
  const AlmOvPg({super.key});

  @override
  State<AlmOvPg> createState() => _AlarmOverlayPageState();
}

class _AlarmOverlayPageState extends State<AlmOvPg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.alarmBounce,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scrim,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: AppBlur.overlaySigma,
              sigmaY: AppBlur.overlaySigma,
            ),
            child: const SizedBox.expand(),
          ),
          SafeArea(
            child: Center(
              child: ScIn(
                begin: AppMotion.overlayScaleBegin,
                duration: AppMotion.pageIn,
                curve: AppMotion.easeOutBack,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpace.s20),
                  padding: const EdgeInsets.all(AppSpace.s20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.r24),
                    border: Border.all(
                      color: AppColors.primary,
                      width: AppBorderW.emphasis,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              _controller.value * AppOffset.iconBounceY,
                            ),
                            child: child,
                          );
                        },
                        child: Container(
                          width: AppSize.alarmIconCircle,
                          height: AppSize.alarmIconCircle,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primarySoft,
                            border: Border.all(
                              color: AppColors.primarySoftBorder,
                              width: AppBorderW.base,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.backpack,
                            size: AppSize.iconXl,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpace.s8),
                      Text(
                        'Hora de Empacar',
                        style: AppTextStyles.title24,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpace.s4),
                      Text(
                        '7:30 AM',
                        style: AppTextStyles.color(
                          AppTextStyles.size(AppTextStyles.title22, 18),
                          AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpace.s8),
                      const NoteCard(
                        text:
                            'No olvides tu lonchera y el libro de matematicas',
                        backgroundColor: AppColors.background,
                        radius: AppRadius.r12,
                        padding: EdgeInsets.all(AppSpace.s12),
                      ),
                      const SizedBox(height: AppSpace.s12),
                      Btn(
                        label: 'Ya lo hice',
                        icon: Icons.check,
                        onPressed: () => Navigator.of(
                          context,
                        ).pushReplacementNamed(AppRoutes.alarmSuccess),
                      ),
                      const SizedBox(height: AppSpace.s8),
                      TScale(
                        onTap: () => popOrGoDay(context),
                        child: Text('5 minutos mas', style: AppTextStyles.link),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
