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
  Future<int?> updateMonth(Month month);
  @delete
  Future<int?> deleteMonth(Month month);

  @Query('SELECT * FROM work_day WHERE month_id = :monthId')
  Future<List<WorkDay>> getDays(int monthId);
  @insert
  Future<int?> insertDay(WorkDay day);
  @update
  Future<int?> updateDay(WorkDay day);
  @delete
  Future<int?> deleteDay(WorkDay day);
}
