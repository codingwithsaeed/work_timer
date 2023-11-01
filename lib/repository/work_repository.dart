import 'package:injectable/injectable.dart';
import '../db/dao/app_dao.dart';
import '../db/entities/month.dart';
import '../db/entities/work_day.dart';
import '../utils/typedefs.dart';
import 'repo_handler.dart';

abstract interface class WorkRepository {
  Result<List<Month>> getMonths();
  Result<void> upsertMonth(Month month);
  Result<void> deleteMonth(Month month);

  Result<List<WorkDay>> getWorkdays(int monthId);
  Result<void> upsertWorkDay(WorkDay workDay);
  Result<void> deleteWorkDay(WorkDay workDay);
}

@Injectable(as: WorkRepository)
class WorkRepositoryImpl implements WorkRepository {
  final AppDao _dao;
  final RepoHandler _handler;
  const WorkRepositoryImpl(this._dao, this._handler);
  @override
  Result<List<Month>> getMonths() => _handler.handle(
        onCall: () => _dao.getMonths(),
        onSuccess: (result) => result,
        onErrorMessage: 'Cant get months',
      );

  @override
  Result<void> upsertMonth(Month month) => _handler.handle(
        onCall: () => month.id == null ? _dao.insertMonth(month) : _dao.updateMonth(month),
        onErrorMessage: 'Cant add or update month',
      );

  @override
  Result<void> deleteMonth(Month month) => _handler.handle(
        onCall: () => _dao.deleteMonth(month),
        onErrorMessage: 'Cant delete month',
      );

  @override
  Result<List<WorkDay>> getWorkdays(int monthId) => _handler.handle(
        onCall: () => _dao.getDays(monthId),
        onSuccess: (result) => result,
        onErrorMessage: 'Cant get workdays',
      );

  @override
  Result<void> upsertWorkDay(WorkDay workDay) => _handler.handle(
        onCall: () => workDay.id == null ? _dao.insertDay(workDay) : _dao.updateDay(workDay),
        onErrorMessage: 'Cant add or update workday',
      );

  @override
  Result<void> deleteWorkDay(WorkDay workDay) => _handler.handle(
        onCall: () => _dao.deleteDay(workDay),
        onErrorMessage: 'Cant delete workday',
      );
}
