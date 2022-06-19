import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool?>? saveCacheData({required String key, required value}) async {
    if(value is String) await  _preferences!.setString(key, value);
    if(value is int) await  _preferences!.setInt(key, value);
    if(value is double) await  _preferences!.setDouble(key, value);
    if(value is bool) await  _preferences!.setBool(key, value);
    await  _preferences!.setStringList(key, value);
    return null;
  }

  Object? getCacheData({required String key}) {
    return  _preferences!.get(key);
  }

  Future<bool> deleteCacheData({required String key}) async {
    return await _preferences!.remove(key);
  }
}