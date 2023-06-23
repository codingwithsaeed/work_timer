import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:work_timer/db/converters/time_converter.dart';
import 'converters/date_time_converter.dart';
import 'converters/bool_converter.dart';
import 'dao/app_dao.dart';
import 'entities/month.dart';
import 'entities/work_day.dart';

part 'app_db.g.dart';

@TypeConverters([DateTimeConverter, TimeConverter, BoolConverter])
@Database(version: 1, entities: [Month, WorkDay])
abstract class AppDB extends FloorDatabase {
  AppDao get appDao;
}
