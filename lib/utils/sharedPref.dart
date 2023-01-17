import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "_darkTheme";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("_darkTheme");
  }
}
