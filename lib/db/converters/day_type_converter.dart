import 'package:floor/floor.dart';
import 'package:work_timer/db/entities/work_day.dart';

class DayTypeConverter extends TypeConverter<WorkDayType, String> {
  @override
  WorkDayType decode(String databaseValue) => WorkDayType.values.byName(databaseValue);

  @override
  String encode(WorkDayType value) => value.name;
}
