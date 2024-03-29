import 'package:flutter/material.dart';

// App相关
class ApplicationViewModel extends ChangeNotifier {
  //目前仅记录主题相关
  // 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  // 多主题模式
  String _multipleThemesMode = "default";

  bool _loginState = false;

  // 设置-主题模式
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setLoginState(bool value){
    _loginState = value;
    notifyListeners();
  }

  // 设置-多主题模式
  void setMultipleThemesMode(String multipleThemesMode) {
    _multipleThemesMode = multipleThemesMode;
    notifyListeners();
  }



  ThemeMode get themeMode => _themeMode;
  String get multipleThemesMode => _multipleThemesMode;
  bool get loginState => _loginState;

}
