import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import '../../db/entities/month.dart';
import '../../db/entities/work_day.dart';
import '../../repository/work_repository.dart';
import 'error_store.dart';

part 'work_store.g.dart';

@injectable
class WorkStore = _WorkStoreBase with _$WorkStore;

abstract class _WorkStoreBase with Store {
  final WorkRepository _repository;
  final ErrorStore errorStore;
  _WorkStoreBase(this._repository, this.errorStore);

  @observable
  bool isLoading = false;
  @action
  void setLoading(bool isLoading) => this.isLoading = isLoading;

  ObservableList<Month> months = ObservableList();
  @action
  void setMonths(List<Month> months) => this.months = ObservableList.of(months);

  @observable
  ObservableList<WorkDay> workDays = ObservableList();
  @action
  void setWorkDays(List<WorkDay> workDays) => this.workDays = ObservableList.of(workDays);

  @observable
  Month? currentMonth;
  @action
  void setCurrentMonth(Month? currentMonth) => this.currentMonth = currentMonth;

  Future<void> getMonths() async {
    setLoading(true);
    final result = await _repository.getMonths();
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (months) => setMonths(months),
    );
    setLoading(false);
  }

  Future<void> insertMonth(Month month) async {
    setLoading(true);
    final result = await _repository.insertMonth(month);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getMonths(),
    );
    setLoading(false);
  }

  Future<void> updateMonth(Month month) async {
    setLoading(true);
    final result = await _repository.updateMonth(month);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getMonths(),
    );
    setLoading(false);
  }

  Future<void> deleteMonth(Month month) async {
    setLoading(true);
    final result = await _repository.deleteMonth(month);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getMonths(),
    );
    setLoading(false);
  }

  Future<void> getWorkDays() async {
    if (currentMonth == null) return;
    setLoading(true);
    final result = await _repository.getWorkdays(currentMonth!.id!);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (workDays) => setWorkDays(workDays),
    );
    setLoading(false);
  }

  Future<void> insertWorkDay(WorkDay day) async {
    setLoading(true);
    final result = await _repository.insertWorkDay(day);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getWorkDays(),
    );
    setLoading(false);
  }

  Future<void> updateWorkDay(WorkDay day) async {
    setLoading(true);
    final result = await _repository.updateWorkDay(day);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getWorkDays(),
    );
    setLoading(false);
  }

  Future<void> deleteWorkDay(WorkDay day) async {
    setLoading(true);
    final result = await _repository.deleteWorkDay(day);
    result.fold(
      (failure) => errorStore.setError(failure.error),
      (_) async => await getWorkDays(),
    );
    setLoading(false);
  }
}