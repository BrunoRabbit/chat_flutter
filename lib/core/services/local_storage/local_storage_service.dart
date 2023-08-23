import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<bool> save<V>(String key, V value);
  Future<V?> read<V>(String key);
  Future<bool> deleteKey(String key);
  Future<bool> deleteAllKeys();
  Future<Set<String>> getAllKeys();
  Object? getUniqueKey(String key);

  factory LocalStorageService() {
    return LocalStorageServiceImpl();
  }
}

class LocalStorageServiceImpl implements LocalStorageService {
  @override
  Future<bool> save<V>(String key, V value) async {
    SharedPreferences storage = await _getSharedInstance();

    return switch (V) {
      String => await storage.setString(key, value as String),
      double => await storage.setDouble(key, value as double),
      bool => await storage.setBool(key, value as bool),
      int => await storage.setInt(key, value as int),
      <String>[] => await storage.setStringList(key, value as List<String>),
      _ => false,
    };
  }

  @override
  Future<V?> read<V>(String key) async {
    SharedPreferences storage = await _getSharedInstance();

    return switch (V) {
      String => storage.getString(key),
      double => storage.getDouble(key),
      bool => storage.getBool(key),
      int => storage.getInt(key),
      <String>[] => storage.getStringList(key),
      _ => throw Exception("Unsupported generic type"),
    } as V?;
  }

  @override
  Future<bool> deleteKey(String key) async {
    SharedPreferences storage = await _getSharedInstance();

    return await storage.remove(key);
  }

  @override
  Future<bool> deleteAllKeys() async {
    SharedPreferences storage = await _getSharedInstance();

    return await storage.clear();
  }

  @override
  Future<Set<String>> getAllKeys() async {
    SharedPreferences storage = await _getSharedInstance();
    return storage.getKeys();
  }

  @override
  Future<Object?> getUniqueKey(String key) async {
    SharedPreferences storage = await _getSharedInstance();
    return storage.get(key);
  }

  Future<SharedPreferences> _getSharedInstance() async {
    return await SharedPreferences.getInstance();
  }
}
