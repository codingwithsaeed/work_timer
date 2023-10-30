import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:work_timer/db/entities/time.dart';
import 'package:work_timer/main.dart';
import 'package:work_timer/utils/extensions.dart';
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
  Time get workHours {
    Time time = const Time(hour: '0', minute: '00');
    for (final day in workDays) {
      if (day.type != WorkDayType.absence) {
        time = time.add(day.exit.differenceWith(day.arrival));
      }
    }
    return time.padLeft();
  }

  @computed
  Time get remainingTime {
    if (isOvertime) return calculatedTime.differenceWith(currentMonth!.dutyHours.time).padLeft();
    return currentMonth!.dutyHours.time.differenceWith(calculatedTime).padLeft();
  }

  @computed
  Time get absenceTime {
    return currentMonth!.absenceHours.time.padLeft();
  }

  @computed
  Time get sumOfUsedAbsenceTime {
    Time time = const Time(hour: '0', minute: '00');
    for (final day in workDays) {
      if (day.type == WorkDayType.absence) {
        time = time.add(day.exit.differenceWith(day.arrival));
      }
    }
    return time.padLeft();
  }

  @computed
  Time get sumOfRemainingAbsenceTime {
    if (sumOfUsedAbsenceTime >= absenceTime) return const Time(hour: '00', minute: '00');
    return absenceTime.differenceWith(sumOfUsedAbsenceTime).padLeft();
  }

  @computed
  Time get sumOfRemoteTime {
    Time time = const Time(hour: '0', minute: '00');
    for (final day in workDays) {
      if (day.type == WorkDayType.remote) {
        time = time.add(day.exit.differenceWith(day.arrival));
      }
    }
    return time.padLeft();
  }

  @computed
  Time get sumOfMissionTime {
    Time time = const Time(hour: '0', minute: '00');
    for (final day in workDays) {
      if (day.type == WorkDayType.mission) {
        time = time.add(day.exit.differenceWith(day.arrival));
      }
    }
    return time.padLeft();
  }

  @computed
  Time get extraAbsenceTime {
    if (sumOfUsedAbsenceTime <= absenceTime) return const Time(hour: '00', minute: '00');
    return sumOfUsedAbsenceTime.differenceWith(absenceTime).padLeft();
  }

  @computed
  Time get calculatedTime => totalTime - extraAbsenceTime;

  @computed
  bool get isOvertime => calculatedTime > currentMonth!.dutyHours.time;

  @computed
  double get progressValue {
    final value = calculatedTime.percentOf(currentMonth!.dutyHours.time);
    return value > 1.0 ? 1.0 : value;
  }

  @computed
  String get progressText {
    final percent = (progressValue * 100).toStringAsFixed(1);
    return '$percent %';
  }

  @computed
  Time get dutyHours {
    return currentMonth!.dutyHours.time.padLeft();
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

  Future<String?> insertWorkDay(WorkDay day) async {
    if (hasConflict(day)) {
      return navKey.currentContext!.l10n.dayHasConflict;
    }
    setLoading(true);
    final result = await _repository.insertWorkDay(day);
    setLoading(false);
    return result.fold(
      (failure) {
        errorStore.setError(failure.error);
        return failure.error;
      },
      (_) async {
        await getWorkDays();
        return null;
      },
    );
  }

  Future<void> updateWorkDay(WorkDay day) async {
    if (hasConflict(day)) {
      errorStore.setError(navKey.currentContext!.l10n.dayHasConflict);
      return;
    }
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

  bool hasConflict(WorkDay day) {
    for (final workday in workDays) {
      if (day.hasConflictWith(workday)) return true;
    }
    return false;
  }
}
