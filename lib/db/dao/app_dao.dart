import 'package:floor/floor.dart';
import '../entities/month.dart';
import '../entities/work_day.dart';

@dao
abstract class AppDao {
  @Query('SELECT * FROM Month')
  Future<List<Month>> getMonths();
  @insert
  Future<int?> insertMonth(Month month);
  @update
  Future<void> updateMonth(Month month);
  @delete
  Future<void> deleteMonth(Month month);

  @Query('SELECT * FROM work_day WHERE month_id = :monthId')
  Future<List<WorkDay>> getDays(int monthId);
  @insert
  Future<int?> insertDay(WorkDay day);
  @update
  Future<void> updateDay(WorkDay day);
  @delete
  Future<void> deleteDay(WorkDay day);
}
