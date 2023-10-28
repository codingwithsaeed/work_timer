import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:work_timer/db/entities/time.dart';
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
  void setMonths(List<Month> months) {
    this.months.clear();
    this.months.addAll(months);
  }

  @observable
  ObservableList<WorkDay> workDays = ObservableList();
  @action
  void setWorkDays(List<WorkDay> workDays) => this.workDays = ObservableList.of(workDays);

  @computed
  List<WorkDay> get sortedByDate => workDays.toList()..sort((a, b) => a.date.compareTo(b.date));

  @observable
  Month? currentMonth;
  @action
  void setCurrentMonth(Month? currentMonth) => this.currentMonth = currentMonth;

  @computed
  Time get totalTime {
    Time time = const Time(hour: '0', minute: '00');
    for (final day in workDays) {
      time = time.add(day.exit.differenceWith(day.arrival));
    }
    return time.padLeft();
  }

  @computed
  Time get remainingTime {
    return currentMonth!.dutyHours.time.differenceWith(totalTime);
  }

  @computed
  double get progressValue {
    return totalTime.percentOf(currentMonth!.dutyHours.time);
  }

  @computed
  String get progressText {
    final percent = (progressValue * 100).toStringAsFixed(1);
    return '$percent %';
  }

  @computed
  Color get progressColor {
    if (progressValue < 0.3) return Colors.red;
    if (progressValue < 0.6) return Colors.orange;
    return Colors.green;
  }

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
