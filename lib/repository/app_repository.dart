import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:work_timer/db/shared_pref/shared_pref.dart';
import 'package:work_timer/presentation/stores/app_store.dart';
import 'package:work_timer/utils/app_theme.dart';
import 'package:work_timer/utils/failures.dart';
import 'package:work_timer/utils/typedefs.dart';

abstract interface class AppRepository {
  Result<bool> setAppLocale(AppLocales locale);
  AppLocales getAppLocale();
  Result<bool> setScheme(ThemeScheme scheme);
  ThemeScheme getScheme();
}

@Injectable(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final SharedPref _pref;
  const AppRepositoryImpl(this._pref);

  @override
  AppLocales getAppLocale() {
    try {
      final locale = _pref.get(SharedPrefKeys.locale.name);
      if (locale != null) return AppLocales.values.byName(locale);
      return AppLocales.fa;
    } catch (e) {
      return AppLocales.fa;
    }
  }

  @override
  ThemeScheme getScheme() {
    try {
      final scheme = _pref.get(SharedPrefKeys.scheme.name);
      if (scheme != null) return ThemeScheme.values.byName(scheme);
      return ThemeScheme.violet;
    } catch (e) {
      return ThemeScheme.violet;
    }
  }

  @override
  Result<bool> setAppLocale(AppLocales locale) async {
    try {
      final res = await _pref.save(SharedPrefKeys.locale.name, locale.name);
      return Right(res);
    } catch (e) {
      return const Left(DBFailure('Cant save locale'));
    }
  }

  @override
  Result<bool> setScheme(ThemeScheme scheme) async {
    try {
      final res = await _pref.save(SharedPrefKeys.scheme.name, scheme.name);
      return Right(res);
    } catch (e) {
      return const Left(DBFailure('Cant save scheme'));
    }
  }
}
