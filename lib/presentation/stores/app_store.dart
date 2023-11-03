import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:work_timer/repository/app_repository.dart';
import 'package:work_timer/utils/app_theme.dart';
import 'package:work_timer/utils/extensions.dart';
part 'app_store.g.dart';

enum AppLocales {
  en,
  fa;

  String nameIn(BuildContext context) {
    return switch (this) {
      AppLocales.fa => context.l10n.fa,
      AppLocales.en => context.l10n.en,
    };
  }
  Locale get locale => Locale(name);
}

@injectable
class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final AppRepository _repository;
  _AppStoreBase(this._repository);

  void init() {
    setLocale(_repository.getAppLocale());
    setTheme(_repository.getScheme());
  }

  @observable
  AppLocales locale = AppLocales.fa;
  @action
  void setLocale(AppLocales locale) {
    if (locale == this.locale) return;
    this.locale = locale;
    _repository.setAppLocale(locale);
  }

  @observable
  ThemeScheme scheme = ThemeScheme.violet;
  @action
  void setTheme(ThemeScheme scheme) {
    if (scheme == this.scheme) return;
    this.scheme = scheme;
    _repository.setScheme(scheme);
  }

  @computed
  Locale get currentLocal => locale.locale;
}
