import 'task_item_card.dart';
import '../../../app/router.dart';
import 'package:flutter/material.dart';
import '../widgets/child_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../domain/models/child_models.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_progress_bar.dart';
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

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _scheduleTestAlarm() async {
    try {
      final AlarmPermissionStatus permissions = await _alarmService
          .ensureAlarmPermissions();

      if (!permissions.canScheduleAlarm) {
        _showMessage('Activa permisos para programar alarmas');
        return;
      }

      final DateTime now = DateTime.now();
      final DateTime scheduleAt = now.add(const Duration(seconds: 10));

      await _alarmService.scheduleAlarm(
        alarmId: 10001,
        when: scheduleAt,
        payload: AppRoutes.alarm,
        title: 'Hora de Empacar',
        body: 'No olvides tu lonchera y el libro de matematicas',
      );
      _showMessage('Alarma de prueba en 10 segundos');
    } catch (_) {
      _showMessage('No se pudo crear la alarma de prueba');
    }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header with border-bottom (centered, like prototype)
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.s16,
              AppSpace.s20,
              AppSpace.s16,
              AppSpace.s16,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.border,
                  width: AppBorderW.base,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFF59E0B),
                      size: 24,
                    ),
                    const SizedBox(width: AppSpace.s8),
                    Text(
                      'Mi Dia — ${profile.name}',
                      style: AppTextStyles.title22,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.s4),
                Text(
                  profile.dateLabel.toUpperCase(),
                  style: AppTextStyles.label12,
                ),
                const SizedBox(height: AppSpace.s8),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.backpack,
                        color: AppColors.successStrong,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        profile.dayTypeLabel,
                        style: AppTextStyles.color(
                          AppTextStyles.label13,
                          AppColors.successStrong,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpace.s16),
              children: <Widget>[
                ...tasks.asMap().entries.map(
                  (MapEntry<int, ChildTask> entry) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpace.s12),
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
                  ),
                ),
                const SizedBox(height: AppSpace.s8),
                // Progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    PBar(value: progress, color: AppColors.primary),
                    const SizedBox(height: AppSpace.s4),
                    Text(
                      '$completedCount/$total completadas',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label13,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.s16),
                Btn(
                  label: 'Mi Alarma',
                  icon: Icons.alarm,
                  variant: BtnVar.secondary,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.createAlarm),
                ),
                const SizedBox(height: AppSpace.s8),
                Btn(
                  label: 'Probar alarma (10s)',
                  icon: Icons.notifications_active,
                  variant: BtnVar.ghost,
                  onPressed: _scheduleTestAlarm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
