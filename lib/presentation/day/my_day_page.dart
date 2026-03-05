import 'task_item_card.dart';
import '../../../app/router.dart';
import 'package:flutter/material.dart';
import '../widgets/child_scaffold.dart';
import '../widgets/section_block.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../domain/models/child_models.dart';
import '../widgets/progress_summary_card.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/activity_icon.dart';
import '../../data/mock/child_mock_repository.dart';
import '../../../src/alarm/alarm_notification_service.dart';

class DayPg extends StatefulWidget {
  const DayPg({super.key});

  @override
  State<DayPg> createState() => _MyDayPageState();
}

class _MyDayPageState extends State<DayPg> {
  final ChildMockRepository _repo = ChildMockRepository.instance;
  final AlarmNotificationService _alarmService =
      AlarmNotificationService.instance;

  Future<void> _scheduleTestAlarm() async {
    try {
      final AlarmPermissionStatus permissions = await _alarmService
          .ensureAlarmPermissions();

      if (!permissions.canScheduleAlarm) return;

      final DateTime now = DateTime.now();
      final DateTime scheduleAt = now.add(const Duration(seconds: 10));

      await _alarmService.scheduleAlarm(
        alarmId: 10001,
        when: scheduleAt,
        payload: AppRoutes.alarm,
        title: 'Hora de Empacar',
        body: 'No olvides tu lonchera y el libro de matematicas',
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final List<ChildTask> tasks = _repo.getTasks();
    final int completedCount = _repo.completedCount;
    final int total = _repo.totalTasks;
    final double progress = _repo.dayProgress;
    final profile = _repo.childProfile;

    return CScaf(
      currentRoute: AppRoutes.day,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.s16,
          AppSpace.s20,
          AppSpace.s16,
          AppSpace.s16,
        ),
        children: <Widget>[
          Text('Mi Dia - ${profile.name}', style: AppTextStyles.title22),
          const SizedBox(height: AppSpace.s4),
          Text(profile.dateLabel, style: AppTextStyles.label14),
          const SizedBox(height: AppSpace.s16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.s8,
              vertical: AppSpace.s8,
            ),
            decoration: BoxDecoration(
              color: AppColors.successSoft,
              borderRadius: BorderRadius.circular(AppRadius.r20),
              border: Border.all(
                color: AppColors.success,
                width: AppBorderW.base,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const AIcon(
                  iconKey: 'backpack',
                  size: AIconSz.sm,
                  bgColor: AppColors.successSoft,
                  borderColor: AppColors.successSoftBorder,
                  iconColor: AppColors.successStrong,
                ),
                const SizedBox(width: AppSpace.s8),
                Text(
                  profile.dayTypeLabel,
                  style: AppTextStyles.color(
                    AppTextStyles.label12,
                    AppColors.successStrong,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          SecBlock(
            title: 'Resumen',
            child: ProgCard(
              title: 'Progreso de Hoy',
              progress: progress,
              counterLabel: '$completedCount/$total',
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          SecBlock(
            title: 'Tareas',
            child: Column(
              children: tasks.asMap().entries.map((MapEntry<int, ChildTask> entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.s8),
                  child: TaskCard(
                    index: entry.key,
                    task: entry.value,
                    onTap: () async {
                      await Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.activity(entry.value.id));
                      if (!mounted) return;
                      setState(() {});
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpace.s4),
          Btn(
            label: 'Mi Alarma',
            icon: Icons.alarm,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.createAlarm),
          ),
          const SizedBox(height: AppSpace.s8),
          Btn(
            label: 'Probar alarma (10s)',
            icon: Icons.notifications_active,
            variant: BtnVar.outline,
            onPressed: _scheduleTestAlarm,
          ),
        ],
      ),
    );
  }
}
