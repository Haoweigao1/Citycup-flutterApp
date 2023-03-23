import 'package:flutter/material.dart';


class UserInfo extends ChangeNotifier{
    String _uid = "";
    String _nickname = "";
    String _avatar = "";
    String _phone = "";
    String _email = "";
    String _gender = "";
    String _description = "";
    String _hash = "";
    String _token = "";

    String get uid => _uid;

    set uid(String value) {
      _uid = value;
      notifyListeners();
    }

    String get gender => _gender;

    set gender(String value){
      _gender = value;
      notifyListeners();
    }


    String get nickname => _nickname;

    set nickname(String value) {
      _nickname = value;
      notifyListeners();
    }


    String get avatar => _avatar;

    set avatar(String value) {
      _avatar = value;
      notifyListeners();
    }

    String get phone => _phone;

    set phone(String value) {
      _phone = value;
      notifyListeners();
    }

    String get email => _email;

    set email(String value) {
      _email = value;
      notifyListeners();
    }

    String get description => _description;

    set description(String value) {
      _description = value;
      notifyListeners();
    }

    String get hash => _hash;

    set hash(String value) {
      _hash = value;
      notifyListeners();
    }

    String get token => _token;

    set token(String value) {
      _token = value;
      notifyListeners();
    }

}