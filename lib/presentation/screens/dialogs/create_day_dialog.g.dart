// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_day_dialog.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateDayStore on _CreateDayStoreBase, Store {
  Computed<String>? _$dateTextComputed;

  @override
  String get dateText =>
      (_$dateTextComputed ??= Computed<String>(() => super.dateText,
              name: '_CreateDayStoreBase.dateText'))
          .value;
  Computed<String>? _$arrivalTextComputed;

  @override
  String get arrivalText =>
      (_$arrivalTextComputed ??= Computed<String>(() => super.arrivalText,
              name: '_CreateDayStoreBase.arrivalText'))
          .value;
  Computed<String>? _$exitTextComputed;

  @override
  String get exitText =>
      (_$exitTextComputed ??= Computed<String>(() => super.exitText,
              name: '_CreateDayStoreBase.exitText'))
          .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_CreateDayStoreBase.isValid'))
      .value;
  Computed<WorkDay?>? _$workDayComputed;

  @override
  WorkDay? get workDay =>
      (_$workDayComputed ??= Computed<WorkDay?>(() => super.workDay,
              name: '_CreateDayStoreBase.workDay'))
          .value;

  late final _$dateAtom =
      Atom(name: '_CreateDayStoreBase.date', context: context);

  @override
  DateTime? get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime? value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$arrivalAtom =
      Atom(name: '_CreateDayStoreBase.arrival', context: context);

  @override
  Time? get arrival {
    _$arrivalAtom.reportRead();
    return super.arrival;
  }

  @override
  set arrival(Time? value) {
    _$arrivalAtom.reportWrite(value, super.arrival, () {
      super.arrival = value;
    });
  }

  late final _$exitAtom =
      Atom(name: '_CreateDayStoreBase.exit', context: context);

  @override
  Time? get exit {
    _$exitAtom.reportRead();
    return super.exit;
  }

  @override
  set exit(Time? value) {
    _$exitAtom.reportWrite(value, super.exit, () {
      super.exit = value;
    });
  }

  late final _$isRemoteAtom =
      Atom(name: '_CreateDayStoreBase.isRemote', context: context);

  @override
  bool get isRemote {
    _$isRemoteAtom.reportRead();
    return super.isRemote;
  }

  @override
  set isRemote(bool value) {
    _$isRemoteAtom.reportWrite(value, super.isRemote, () {
      super.isRemote = value;
    });
  }

  late final _$_CreateDayStoreBaseActionController =
      ActionController(name: '_CreateDayStoreBase', context: context);

  @override
  void setDate(DateTime? date) {
    final _$actionInfo = _$_CreateDayStoreBaseActionController.startAction(
        name: '_CreateDayStoreBase.setDate');
    try {
      return super.setDate(date);
    } finally {
      _$_CreateDayStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setArrival(Time? arrival) {
    final _$actionInfo = _$_CreateDayStoreBaseActionController.startAction(
        name: '_CreateDayStoreBase.setArrival');
    try {
      return super.setArrival(arrival);
    } finally {
      _$_CreateDayStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExit(Time? exit) {
    final _$actionInfo = _$_CreateDayStoreBaseActionController.startAction(
        name: '_CreateDayStoreBase.setExit');
    try {
      return super.setExit(exit);
    } finally {
      _$_CreateDayStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsRemote(bool isRemote) {
    final _$actionInfo = _$_CreateDayStoreBaseActionController.startAction(
        name: '_CreateDayStoreBase.setIsRemote');
    try {
      return super.setIsRemote(isRemote);
    } finally {
      _$_CreateDayStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
date: ${date},
arrival: ${arrival},
exit: ${exit},
isRemote: ${isRemote},
dateText: ${dateText},
arrivalText: ${arrivalText},
exitText: ${exitText},
isValid: ${isValid},
workDay: ${workDay}
    ''';
  }
}
