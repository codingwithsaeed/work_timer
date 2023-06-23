// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:work_timer/db/app_db.dart' as _i3;
import 'package:work_timer/db/dao/app_dao.dart' as _i4;
import 'package:work_timer/di/injector_modules.dart' as _i10;
import 'package:work_timer/presentation/stores/error_store.dart' as _i5;
import 'package:work_timer/presentation/stores/work_store.dart' as _i9;
import 'package:work_timer/repository/repo_handler.dart' as _i6;
import 'package:work_timer/repository/work_repository.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectorModules = _$InjectorModules();
    await gh.factoryAsync<_i3.AppDB>(
      () => injectorModules.appDB,
      preResolve: true,
    );
    await gh.factoryAsync<_i4.AppDao>(
      () => injectorModules.workDayDao,
      preResolve: true,
    );
    gh.factory<_i5.ErrorStore>(() => _i5.ErrorStore());
    gh.factory<_i6.RepoHandler>(() => _i6.RepoHandlerImpl());
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => injectorModules.sharedPrefrences,
      preResolve: true,
    );
    gh.factory<_i8.WorkRepository>(() => _i8.WorkRepositoryImpl(
          gh<_i4.AppDao>(),
          gh<_i6.RepoHandler>(),
        ));
    gh.factory<_i9.WorkStore>(() => _i9.WorkStore(
          gh<_i8.WorkRepository>(),
          gh<_i5.ErrorStore>(),
        ));
    return this;
  }
}

class _$InjectorModules extends _i10.InjectorModules {}
