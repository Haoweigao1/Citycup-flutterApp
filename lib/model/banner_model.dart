


import 'package:flutter/material.dart';

import '../entity/banner_entity.dart';
import '../entity/news_entity.dart';

class BannerModel extends ChangeNotifier{

  List<BannerEntity> _bannerList = [];




  List<BannerEntity> get bannerList => _bannerList;

  set bannerList(List<BannerEntity> value) {
    _bannerList = value;
    notifyListeners();
  }

}
