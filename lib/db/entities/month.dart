import 'package:floor/floor.dart';

@entity
class Month {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  @ColumnInfo(name: 'duty_hours')
  final int dutyHours;

  const Month({this.id, required this.name, required this.dutyHours});

  Month copyWith({int? id, String? name, int? dutyHours}) {
    return Month(
      id: id ?? this.id,
      name: name ?? this.name,
      dutyHours: dutyHours ?? this.dutyHours,
    );
  }

  @override
  String toString() => 'Month(id: $id, name: $name, dutyHours: $dutyHours)';
}
