import 'package:flutter/material.dart';


class UserInfo extends ChangeNotifier{
  String _uid = "";
  String _username = "";
  String _nickname = "";
  String _avatar = "";
  String _phone = "";
  String _email = "";


  set uid(String value) {
    _uid = value;
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set nickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  set avatar(String value) {
    _avatar = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }




  String get uid => _uid;
  String get username => _username;
  String get nickname => _nickname;
  String get avatar => _avatar;
  String get phone => _phone;
  String get email => _email;

}