import 'package:shared_preferences/shared_preferences.dart';

class Commonwidgets {

   int _getIntFromPrefs(SharedPreferences prefs, String key) {
    final value = prefs.getString(key);
    if (value != null) {
      try {
        return int.parse(value);
      } catch (e) {

        print('Error parsing integer from SharedPreferences: $e');
        
        return 0;
      }
    }
    return 0;
  }




}