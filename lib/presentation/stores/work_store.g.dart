// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkStore on _WorkStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_WorkStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$workDaysAtom =
      Atom(name: '_WorkStoreBase.workDays', context: context);

  @override
  ObservableList<WorkDay> get workDays {
    _$workDaysAtom.reportRead();
    return super.workDays;
  }

  @override
  set workDays(ObservableList<WorkDay> value) {
    _$workDaysAtom.reportWrite(value, super.workDays, () {
      super.workDays = value;
    });
  }

  late final _$currentMonthAtom =
      Atom(name: '_WorkStoreBase.currentMonth', context: context);

  @override
  Month? get currentMonth {
    _$currentMonthAtom.reportRead();
    return super.currentMonth;
  }

  @override
  set currentMonth(Month? value) {
    _$currentMonthAtom.reportWrite(value, super.currentMonth, () {
      super.currentMonth = value;
    });
  }

  late final _$_WorkStoreBaseActionController =
      ActionController(name: '_WorkStoreBase', context: context);

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_WorkStoreBaseActionController.startAction(
        name: '_WorkStoreBase.setLoading');
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_WorkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMonths(List<Month> months) {
    final _$actionInfo = _$_WorkStoreBaseActionController.startAction(
        name: '_WorkStoreBase.setMonths');
    try {
      return super.setMonths(months);
    } finally {
      _$_WorkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkDays(List<WorkDay> workDays) {
    final _$actionInfo = _$_WorkStoreBaseActionController.startAction(
        name: '_WorkStoreBase.setWorkDays');
    try {
      return super.setWorkDays(workDays);
    } finally {
      _$_WorkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentMonth(Month? currentMonth) {
    final _$actionInfo = _$_WorkStoreBaseActionController.startAction(
        name: '_WorkStoreBase.setCurrentMonth');
    try {
      return super.setCurrentMonth(currentMonth);
    } finally {
      _$_WorkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
workDays: ${workDays},
currentMonth: ${currentMonth}
    ''';
  }
}
