import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<String> getPrefs(dynamic namePrefs)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(namePrefs)??null;
  }

  static Future<bool> setPrefs(dynamic namePrefs, dynamic value)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(namePrefs, value);
  }
}