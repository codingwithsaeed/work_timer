import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'error_store.g.dart';

@injectable
class ErrorStore = _ErrorStoreBase with _$ErrorStore;

abstract class _ErrorStoreBase with Store {
  _ErrorStoreBase() {
    reaction((_) => error, (_) => clear(), delay: 4000);
  }

  @observable
  String error = '';
  @action
  void setError(String error) {
    log('Error: $error');
    this.error = error;
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @action
  void clear() => error = '';
}
