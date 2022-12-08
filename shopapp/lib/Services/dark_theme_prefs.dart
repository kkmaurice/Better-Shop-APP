import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  // key
  static const THEME_STATUS = 'THEMESTATUS';
  
  // method to set dark theme state
  setDarkTheme(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('repeat', value??false); 
  }

  // method to get the dark theme state
  getDarkTheme() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool(THEME_STATUS);
  }

}