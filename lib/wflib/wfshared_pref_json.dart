import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WFSharedPrefJson {
  static Future<dynamic> read(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return json.decode(prefs.getString(key) ?? '{}');
    } on Exception catch (e) {
      print("read catch=$e");
      return json.decode('{}');
    }
  }

  static Future<bool> save(String key, value) async {
    try {
      print("save=" + value);
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(key, json.encode(value));
    } on Exception catch (e) {
      print("save catch=$e");
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key);
    } on Exception catch (e) {
      print("remove catch=$e");
      return false;
    }
  }
}
