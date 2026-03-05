import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/tap_scale.dart';
import '../../domain/models/child_models.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/activity_icon.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.onTap,
  });

  final ChildTask task;
  final int index;
  final VoidCallback onTap;

  @override
  State<TaskCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool get _isActive => widget.task.status == TaskStatus.active;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.activeChevron,
    );

    if (_isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isActive) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = widget.task.status == TaskStatus.completed;
    final bool tappable = !isCompleted;

    final Color bg = isCompleted ? AppColors.surfaceMuted : AppColors.surface;
    final Color border = _isActive ? AppColors.primary : AppColors.border;
    final double borderWidth = _isActive ? AppBorderW.active : AppBorderW.base;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(
        milliseconds:
            AppMotion.itemBaseMs + (widget.index * AppMotion.itemStaggerMs),
      ),
      curve: AppMotion.easeOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * AppOffset.pageEntryY),
            child: child,
          ),
        );
      },
      child: TScale(
        onTap: tappable ? widget.onTap : null,
        child: Container(
          padding: const EdgeInsets.all(AppSpace.s12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.r16),
            border: Border.all(color: border, width: borderWidth),
            boxShadow: _isActive ? AppShadow.activeCard : null,
          ),
          child: Row(
            children: <Widget>[
              AIcon(iconKey: widget.task.iconKey, size: AIconSz.md),
              const SizedBox(width: AppSpace.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.task.title,
                      style: AppTextStyles.color(
                        AppTextStyles.body16,
                        isCompleted
                            ? AppColors.textMuted
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpace.s4),
                    Text(widget.task.timeLabel, style: AppTextStyles.label13),
                  ],
                ),
              ),
              if (isCompleted)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: AppSize.taskCheckBadge,
                      height: AppSize.taskCheckBadge,
                      decoration: BoxDecoration(
                        color: AppColors.successSoft,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.success,
                          width: AppBorderW.base,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.check,
                        size: AppSize.iconSm,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSpace.s8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.s8,
                        vertical: AppSpace.s4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successSoft,
                        borderRadius: BorderRadius.circular(AppRadius.r20),
                        border: Border.all(
                          color: AppColors.success,
                          width: AppBorderW.base,
                        ),
                      ),
                      child: Text(
                        'Hecho',
                        style: AppTextStyles.color(
                          AppTextStyles.size(AppTextStyles.label12, 11),
                          AppColors.success,
                        ),
                      ),
                    ),
                  ],
                )
              else if (_isActive)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? _) {
                    return Transform.translate(
                      offset: Offset(
                        _controller.value * AppOffset.activeChevronX,
                        0,
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        color: AppColors.primary,
                      ),
                    );
                  },
                )
              else
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
