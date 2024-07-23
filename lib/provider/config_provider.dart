import 'package:flutter/material.dart';
class ConfigProvider extends ChangeNotifier{
  /// data languages
  String appLanguage = 'ar';
  String check = '';
  // data theme
  ThemeMode Theme = ThemeMode.dark ;

  void ChangeLanguage(String newLang){

    if(appLanguage == newLang){
      return ;
    } else {
      appLanguage = newLang ;
      notifyListeners();
    }

  }

  void ChangeTheme(ThemeMode mode){

    if(Theme == mode){
      return ;
    } else {
      Theme = mode ;
      notifyListeners();
    }
  }

  bool IsDarkMode(){
    return Theme == ThemeMode.dark ;
  }

  bool IsLightMode(){
    return Theme == ThemeMode.light;
  }

}
