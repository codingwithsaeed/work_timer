import 'package:floor/floor.dart';

class BoolConverter extends TypeConverter<bool, int> {
  @override
  bool decode(int databaseValue) => databaseValue == 1;

  @override
  int encode(bool value) => value ? 1 : 0;
}
