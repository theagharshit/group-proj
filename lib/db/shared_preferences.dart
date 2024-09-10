import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static SharedPreferences? _preferences;
  static String key = 'usertype';

  static init() async{
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }
  static Future saveUserType(String type) async{
    return await _preferences!.setString(key, type);
  }
  static Future<String>? getUserType() async =>
      await _preferences!.getString(key) ?? "";
}