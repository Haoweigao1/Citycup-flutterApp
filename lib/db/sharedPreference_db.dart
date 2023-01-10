import 'package:flutter/material.dart';
import 'package:meta_transaction/model/userInfo.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/application/applicationViewModel.dart';
import '../theme/app_theme.dart';



//使用sharedPreference持久化存储一些配置
class PreferencesDB {

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  // 打开APP次数
  static const openAPPCount = "openAPPCount";

  // 主题外观模式
  // system(默认)：跟随系统 light：普通 dark：深色
  static const appThemeDarkMode = "appThemeDarkMode";

  // 多主题模式
  // default(默认)
  static const appMultipleThemesMode = "appMultipleThemesMode";


  // 用户登录密码
  static const userPassword = "userPassword";

  //用户登录获取的token,可以用于判断用户的登录状态（如token过期，弹出登录过期并重置状态）
  static const userToken = "userToken";




  /// 设置-主题外观模式
  Future setAppThemeDarkMode(ApplicationViewModel applicationViewModel, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appThemeDarkMode, value);
    applicationViewModel.setThemeMode(darkThemeMode(value));
  }

  /// 获取-主题外观模式
  Future<String> getAppThemeDarkMode(ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String themeDarkMode = prefs.getString(appThemeDarkMode) ?? "system";
    applicationViewModel.setThemeMode(darkThemeMode(themeDarkMode));
    return themeDarkMode;
  }

  /// 设置-多主题模式
  Future setMultipleThemesMode(ApplicationViewModel applicationViewModel, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appMultipleThemesMode, value);
    applicationViewModel.setMultipleThemesMode(value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode(ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String multipleThemesMode =
        prefs.getString(appMultipleThemesMode) ?? "default";
    applicationViewModel.setMultipleThemesMode(multipleThemesMode);
    return multipleThemesMode;
  }

  /// 设置-用户密码（记住密码功能）
  Future setUserPassword(String pwd) async{
    SharedPreferences prefs = await init();
    prefs.setString(userPassword, pwd);
  }

  /// 获取-用户密码
  Future<String> getUserPassword() async{
    SharedPreferences prefs = await init();
    String pwd = prefs.getString(userPassword) ?? "default";  //default为如果未存储时返回值
    return pwd;
  }

  /// 设置-token
  Future setUserToken(UserInfo userInfo, String token) async{
    SharedPreferences prefs = await init();
    prefs.setString(userToken, token);
    userInfo.token = token;
  }


  ///获取token
  Future<String> getUserToken(UserInfo userInfo) async{
    SharedPreferences prefs = await init();
    String token = prefs.getString(userToken) ?? "default";
    userInfo.token = token;
    return token;
  }

}
