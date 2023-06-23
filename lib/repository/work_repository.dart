import 'package:injectable/injectable.dart';
import '../db/dao/app_dao.dart';
import '../db/entities/month.dart';
import '../db/entities/work_day.dart';
import '../utils/typedefs.dart';
import 'repo_handler.dart';

abstract interface class WorkRepository {
  Result<List<Month>> getMonths();
  Result<bool> insertMonth(Month month);
  Result<void> updateMonth(Month month);
  Result<void> deleteMonth(Month month);

  Result<List<WorkDay>> getWorkdays(int monthId);
  Result<bool> insertWorkDay(WorkDay workDay);
  Result<void> updateWorkDay(WorkDay workDay);
  Result<void> deleteWorkDay(WorkDay workDay);
}

@Injectable(as: WorkRepository)
class WorkRepositoryImpl implements WorkRepository {
  final AppDao _dao;
  final RepoHandler _handler;
  const WorkRepositoryImpl(this._dao, this._handler);
  @override
  Result<List<Month>> getMonths() {
    return _handler.handle(
      onCall: () => _dao.getMonths(),
      onSuccess: (result) => result,
      onErrorMessage: 'Can\'t get months',
    );
  }

  @override
  Result<bool> insertMonth(Month month) {
    return _handler.handle(
      onCall: () => _dao.insertMonth(month),
      onSuccess: (result) => true,
      onErrorMessage: 'Can\'t add month',
    );
  }

  @override
  Result<void> updateMonth(Month month) {
    return _handler.handle(
      onCall: () => _dao.updateMonth(month),
      onSuccess: (result) {},
    );
  }

  @override
  Result<void> deleteMonth(Month month) {
    return _handler.handle(
      onCall: () => _dao.deleteMonth(month),
      onSuccess: (result) {},
    );
  }

  @override
  Result<List<WorkDay>> getWorkdays(int monthId) {
    return _handler.handle(
      onCall: () => _dao.getDays(monthId),
      onSuccess: (result) => result,
      onErrorMessage: 'Can\'t get workdays',
    );
  }

  @override
  Result<bool> insertWorkDay(WorkDay workDay) {
    return _handler.handle(
      onCall: () => _dao.insertDay(workDay),
      onSuccess: (result) => true,
      onErrorMessage: 'Can\'t add workday',
    );
  }

  @override
  Result<void> updateWorkDay(WorkDay workDay) {
    return _handler.handle(
      onCall: () => _dao.updateDay(workDay),
      onSuccess: (result) {},
    );
  }

  @override
  Result<void> deleteWorkDay(WorkDay workDay) {
    return _handler.handle(
      onCall: () => _dao.deleteDay(workDay),
      onSuccess: (result) {},
    );
  }
}
