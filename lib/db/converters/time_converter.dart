import 'package:floor/floor.dart';

import '../entities/time.dart';

class TimeConverter extends TypeConverter<Time, String> {
  @override
  Time decode(String databaseValue) {
    final List<String> parts = databaseValue.split(':');
    return Time(hour: parts[0], minute: parts[1]);
  }

  @override
  String encode(Time value) => '${value.hour}:${value.minute}';
}
