
import 'package:meta_transaction/api/api.dart';
import 'package:meta_transaction/entity/news_entity.dart';
import 'package:meta_transaction/model/banner_model.dart';
import 'package:meta_transaction/util/common_toast.dart';
import '../constant/constant.dart';
import '../entity/banner_entity.dart';
import '../util/dio_manager.dart';
import '../util/time_util.dart';


class NewsService{
  
  static Future<BannerModel?> getNewsModel() async{
     BannerModel ? res;
     List<BannerEntity> bannerList = [];
     await DioManager.instance.get(API.GET_BANNER_LIST, {}, {}, (data) {
       for(int i = 0; i < data.length; i++){
          BannerEntity bannerItem = BannerEntity();
          bannerItem.bid = data[i]["bid"].toString();
          bannerItem.image = data[i]["image"];
          bannerItem.url = data[i]["url"];
          bannerList.add(bannerItem);
          res = BannerModel();
          res?.bannerList = bannerList;
       }
     }, (error){
       CommonToast.showToast(error);
     });
     return res;
  }


  static Future<List<NewsEntity>> getNewsList(int type, int pageNum) async{
    List<NewsEntity> newsList = [];
    Map<String,String> params = {
      "type": type.toString(),
      "pageNum": pageNum.toString(),
      "pageSize": API.pageSize.toString(),
    };
    await DioManager.instance.get(API.GET_NEWS_LIST, params, {}, (data) {
      for(int i = 0; i < data.length; i ++){
        NewsEntity newsItem = NewsEntity();
        newsItem.nid = data[i]["nid"].toString();
        newsItem.image = data[i]["image"];
        newsItem.summary = data[i]["summary"];
        newsItem.time = timestampToDate(data[i]["time"]);
        newsItem.url = data[i]["url"];
        newsItem.source = data[i]["source"];
        newsList.add(newsItem);
      }
    }, (error){


    });
    return newsList;
  }
  
  
  
}