enum TaskStatus { completed, active, pending }

class ChildProfile {
  const ChildProfile({
    required this.id,
    required this.name,
    required this.dayTypeLabel,
    required this.dateLabel,
  });

  final String id;
  final String name;
  final String dayTypeLabel;
  final String dateLabel;
}

class ChildTask {
  const ChildTask({
    required this.id,
    required this.title,
    required this.timeLabel,
    required this.status,
    required this.iconKey,
    this.note,
  });

  final String id;
  final String title;
  final String timeLabel;
  final TaskStatus status;
  final String iconKey;
  final String? note;

  ChildTask copyWith({TaskStatus? status}) {
    return ChildTask(
      id: id,
      title: title,
      timeLabel: timeLabel,
      status: status ?? this.status,
      iconKey: iconKey,
      note: note,
    );
  }
}

class ChildAlarm {
  const ChildAlarm({
    required this.id,
    required this.title,
    required this.timeHour12,
    required this.minutes,
    required this.isPm,
    required this.iconKey,
    required this.enabled,
  });

  final String id;
  final String title;
  final int timeHour12;
  final int minutes;
  final bool isPm;
  final String iconKey;
  final bool enabled;
}

class AchievementMedal {
  const AchievementMedal({
    required this.id,
    required this.label,
    required this.iconKey,
    required this.toneKey,
  });

  final String id;
  final String label;
  final String iconKey;
  final String toneKey;
}

class AchievementProgress {
  const AchievementProgress({
    required this.title,
    required this.weekStarsFilled,
    required this.weekStarsTotal,
    required this.medals,
    required this.nextMedalName,
    required this.current,
    required this.target,
  });

  final String title;
  final int weekStarsFilled;
  final int weekStarsTotal;
  final List<AchievementMedal> medals;
  final String nextMedalName;
  final int current;
  final int target;

  double get percent => target == 0 ? 0 : current / target;
}
