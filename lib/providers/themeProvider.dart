import 'package:flutter/cupertino.dart';
import 'package:gtd/utils/sharedPref.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  setdarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  getdarkTheme() async {
    var check = await darkThemePreference.getTheme();
    if (check == null) {
      _darkTheme = false;
    } else {
      _darkTheme = await darkThemePreference.getTheme();
    }

    notifyListeners();
  }
}
