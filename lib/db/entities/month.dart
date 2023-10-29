import 'package:floor/floor.dart';

@entity
class Month {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  @ColumnInfo(name: 'duty_hours')
  final int dutyHours;
  @ColumnInfo(name: 'absence_hours')
  final int absenceHours;

  const Month({this.id, required this.name, required this.dutyHours, this.absenceHours = 20});

  Month copyWith({int? id, String? name, int? dutyHours, int? absenceHours}) {
    return Month(
      id: id ?? this.id,
      name: name ?? this.name,
      dutyHours: dutyHours ?? this.dutyHours,
      absenceHours: absenceHours ?? this.absenceHours,
    );
  }

  @override
  String toString() => 'Month(id: $id, name: $name, dutyHours: $dutyHours, absenceHours: $absenceHours)';
}
