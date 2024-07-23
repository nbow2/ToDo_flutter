import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ConfigProvider extends ChangeNotifier{
  /// data languages
  String appLanguage = 'en';
  String check = '';
  String locale ;
  // data theme
  ThemeMode Theme = ThemeMode.dark ;
  bool mode ;

  ConfigProvider({this.locale = 'ar' , this.mode = true})
      : Theme = mode ? ThemeMode.dark :ThemeMode.light {}

  void SaveData()async{
  SharedPreferences per = await SharedPreferences.getInstance();
  per.setString('appLanguage', locale);
  notifyListeners();
}

  void ChangeLanguage(String newLang){

    if(appLanguage == newLang){
      return ;
    } else {
      appLanguage = newLang ;
      notifyListeners();
      SaveData();
    }

  }

  void ChangeTheme(ThemeMode mode){

    if(Theme == mode){
      return ;
    } else {
      Theme = mode ;
      notifyListeners();
      SaveData();
    }
  }

  bool IsDarkMode(){
    return Theme == ThemeMode.dark ;
  }

  bool IsLightMode(){
    return Theme == ThemeMode.light;
  }

}
