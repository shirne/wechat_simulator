import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

const _tokenKey = 'token';

class StoreService {
  static StoreService? _storeService;
  static StoreService get instance => _storeService!;
  factory StoreService() {
    _storeService ??= StoreService._();
    return _storeService!;
  }

  StoreService._();

  late final SharedPreferences prefs;

  Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  Future<void> refresh() async {
    return prefs.reload();
  }

  Future<bool> save<T>(String key, T value) async {
    if (T is bool) {
      return prefs.setBool(key, value as bool);
    } else if (T is int) {
      return prefs.setInt(key, value as int);
    } else if (T is double) {
      return prefs.setDouble(key, value as double);
    } else if (T is String) {
      return prefs.setString(key, value as String);
    } else if (T is List<String>) {
      return prefs.setStringList(key, value as List<String>);
    }
    return false;
  }

  T? fetch<T>(String key) {
    return prefs.get(key) as T?;
  }

  Future<bool> has(String key) async {
    return prefs.containsKey(key);
  }

  Future<bool> clear() async {
    return prefs.clear();
  }

  Future<bool> remove(String key) async {
    return prefs.remove(key);
  }

  Future<bool> clearToken() async {
    return remove(_tokenKey);
  }

  Future<bool> saveToken(User user) async {
    return await save<String>(_tokenKey, user.toString());
  }

  User? fetchToken() {
    final json = fetch(_tokenKey);
    if (json != null) {
      return User.fromJson(jsonDecode(json));
    }
    return null;
  }
}
