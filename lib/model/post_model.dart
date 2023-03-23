


import 'package:flutter/cupertino.dart';

import '../entity/post_entity.dart';

class PostModel extends ChangeNotifier{

  PostEntity _post = PostEntity();
  int _commentNum = 0;
  int _favoriteNum = 0;
  bool _isFavorite = false;  //标识用户是否已经
  bool _isStared = false;  //标识用户是否已经收藏


  PostEntity get post => _post;

  set post(PostEntity value) {
    _post = value;
    notifyListeners();
  }

  int get favoriteNum => _favoriteNum;

  set favoriteNum(int value) {
    _favoriteNum = value;
    notifyListeners();
  }

  int get commentNum => _commentNum;

  set commentNum(int value) {
    _commentNum = value;
    notifyListeners();
  }

  bool get isStared => _isStared;

  set isStared(bool value) {
    _isStared = value;
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }
}