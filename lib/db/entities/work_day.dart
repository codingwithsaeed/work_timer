import 'package:floor/floor.dart';
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
  @ColumnInfo(name: 'is_remote')
  final bool isRemote;
  @ColumnInfo(name: 'month_id')
  final int monthId;

  const WorkDay({
    this.id,
    required this.date,
    required this.arrival,
    required this.exit,
    required this.isRemote,
    required this.monthId,
  });

  WorkDay copyWith({
    DateTime? date,
    Time? arrival,
    Time? exit,
    bool? isRemote,
    int? monthId,
  }) {
    return WorkDay(
      id: id,
      date: date ?? this.date,
      arrival: arrival ?? this.arrival,
      exit: exit ?? this.exit,
      isRemote: isRemote ?? this.isRemote,
      monthId: monthId ?? this.monthId,
    );
  }

  @override
  String toString() =>
      'WorkDay(id: $id, date: $date, arrival: $arrival, exit: $exit, isRemote: $isRemote, monthId: $monthId)';
}
