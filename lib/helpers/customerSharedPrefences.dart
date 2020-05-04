import 'package:shared_preferences/shared_preferences.dart';

class CustomerSharedPrefernces {
  static Map<String, Function> toExecute = new Map();

  static subscribe(String key, Function functionToExecute) {
    if (!toExecute.containsKey(key))
      toExecute.addAll({
        key: functionToExecute,
      });
  }

  static Future<void> setValue(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    toExecute.forEach((keyInternal, function) {
      if (keyInternal == key) function(value);
    });
  }

  static Future<String> getValue(String key) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(key);
    } on Exception {
      return null;
    }
  }

  static Future<void> removeValue(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
    toExecute.forEach((keyInternal, function) {
      if (keyInternal == key) function(null);
    });
  }
}
