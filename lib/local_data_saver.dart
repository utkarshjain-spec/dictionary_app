import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String nameKey = "NAMEKEY";

  static Future<bool> saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey);
  }

  static Future<bool> setSaveWord(List<String> words) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('save words', words);
  }

  static Future<List<String>?> getSaveWord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('save words');
  }

  static Future<bool> setHistory(List<String> historyList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('history', historyList);
  }

  static Future<List<String>?> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('history');
  }
}
