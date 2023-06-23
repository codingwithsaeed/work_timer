// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ErrorStore on _ErrorStoreBase, Store {
  late final _$errorAtom =
      Atom(name: '_ErrorStoreBase.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$_ErrorStoreBaseActionController =
      ActionController(name: '_ErrorStoreBase', context: context);

  @override
  void setError(String error) {
    final _$actionInfo = _$_ErrorStoreBaseActionController.startAction(
        name: '_ErrorStoreBase.setError');
    try {
      return super.setError(error);
    } finally {
      _$_ErrorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_ErrorStoreBaseActionController.startAction(
        name: '_ErrorStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_ErrorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error}
    ''';
  }
}
