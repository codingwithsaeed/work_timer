import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKeys {
  scheme,
  locale;
}

abstract interface class SharedPref {
  SharedPref._();
  Future<bool> save(String key, String value);
  String? get(String key);
  Future<bool> remove(String key);
}

@LazySingleton(as: SharedPref)
class SharedPrefImpl implements SharedPref {
  const SharedPrefImpl(this.preferences);
  final SharedPreferences preferences;

  @override
  String? get(String key) => preferences.getString(key);

  @override
  Future<bool> remove(String key) => preferences.remove(key);

  @override
  Future<bool> save(String key, String value) => preferences.setString(key, value);
}
