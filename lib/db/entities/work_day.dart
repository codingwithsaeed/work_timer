import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:work_timer/utils/extensions.dart';
import 'month.dart';
import 'time.dart';

@Entity(
  tableName: 'work_day',
  foreignKeys: [
    ForeignKey(childColumns: ['month_id'], parentColumns: ['id'], entity: Month)
  ],
)
class WorkDay {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final DateTime date;
  final Time arrival;
  final Time exit;
  @ColumnInfo(name: 'type')
  final WorkDayType type;
  @ColumnInfo(name: 'month_id')
  final int monthId;

  const WorkDay({
    this.id,
    required this.date,
    required this.arrival,
    required this.exit,
    this.type = WorkDayType.presence,
    required this.monthId,
  });

  WorkDay copyWith({
    int? id,
    DateTime? date,
    Time? arrival,
    Time? exit,
    WorkDayType? type,
    int? monthId,
  }) {
    return WorkDay(
      id: id ?? this.id,
      date: date ?? this.date,
      arrival: arrival ?? this.arrival,
      exit: exit ?? this.exit,
      type: type ?? this.type,
      monthId: monthId ?? this.monthId,
    );
  }

  @override
  String toString() => 'WorkDay(id: $id, date: $date, arrival: $arrival, exit: $exit, type: $type, monthId: $monthId)';
}

extension WorkDayExtensions on WorkDay {
  bool _hasConflictWith(WorkDay other) {
    return date.compareTo(other.date) == 0 &&
        ((other.arrival.isBetween(arrival, exit) || other.exit.isBetween(arrival, exit)) ||
            (arrival.isBetween(other.arrival, other.exit) || exit.isBetween(other.arrival, other.exit))) &&
        id != other.id;
  }

  bool hasConflictIn(List<WorkDay> workDays) {
    for (final workDay in workDays) {
      if (_hasConflictWith(workDay)) return true;
    }
    return false;
  }

  bool isEqualTo(WorkDay other) {
    return date.compareTo(other.date) == 0 &&
        arrival.toMinutes == other.arrival.toMinutes &&
        exit.toMinutes == other.exit.toMinutes &&
        type == other.type;
  }
}

enum WorkDayType {
  presence,
  absence,
  remote,
  mission;

  Color get color => workDayColors[this] ?? Colors.black;

  String text(BuildContext context) {
    return switch (this) {
      WorkDayType.presence => context.l10n.presence,
      WorkDayType.absence => context.l10n.absence,
      WorkDayType.remote => context.l10n.remote,
      WorkDayType.mission => context.l10n.mission,
    };
  }
}

final workDayColors = {
  WorkDayType.presence: Colors.green,
  WorkDayType.absence: Colors.red,
  WorkDayType.remote: Colors.blue,
  WorkDayType.mission: Colors.orange,
};
