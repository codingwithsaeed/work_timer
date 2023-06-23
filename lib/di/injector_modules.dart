import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/app_db.dart';
import '../../db/dao/app_dao.dart';

@module
abstract class InjectorModules {
  @preResolve
  Future<SharedPreferences> get sharedPrefrences => SharedPreferences.getInstance();

  @preResolve
  Future<AppDB> get appDB => $FloorAppDB.databaseBuilder('app_db.db').build();

  @preResolve
  Future<AppDao> get workDayDao => appDB.then((db) => db.appDao);
}
