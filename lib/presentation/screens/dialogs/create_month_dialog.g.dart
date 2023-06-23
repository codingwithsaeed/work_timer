// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_month_dialog.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateMonthStore on _CreateMonthStoreBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_CreateMonthStoreBase.isValid'))
      .value;
  Computed<Month?>? _$monthComputed;

  @override
  Month? get month => (_$monthComputed ??= Computed<Month?>(() => super.month,
          name: '_CreateMonthStoreBase.month'))
      .value;

  late final _$nameAtom =
      Atom(name: '_CreateMonthStoreBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$dutyHoursAtom =
      Atom(name: '_CreateMonthStoreBase.dutyHours', context: context);

  @override
  String get dutyHours {
    _$dutyHoursAtom.reportRead();
    return super.dutyHours;
  }

  @override
  set dutyHours(String value) {
    _$dutyHoursAtom.reportWrite(value, super.dutyHours, () {
      super.dutyHours = value;
    });
  }

  late final _$_CreateMonthStoreBaseActionController =
      ActionController(name: '_CreateMonthStoreBase', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_CreateMonthStoreBaseActionController.startAction(
        name: '_CreateMonthStoreBase.setName');
    try {
      return super.setName(name);
    } finally {
      _$_CreateMonthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDutyHours(String dutyHours) {
    final _$actionInfo = _$_CreateMonthStoreBaseActionController.startAction(
        name: '_CreateMonthStoreBase.setDutyHours');
    try {
      return super.setDutyHours(dutyHours);
    } finally {
      _$_CreateMonthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
dutyHours: ${dutyHours},
isValid: ${isValid},
month: ${month}
    ''';
  }
}
