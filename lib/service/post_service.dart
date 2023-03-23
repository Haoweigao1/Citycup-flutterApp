
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta_transaction/api/api.dart';
import 'package:meta_transaction/db/sharedPreference_db.dart';
import 'package:meta_transaction/entity/comment_entity.dart';
import 'package:meta_transaction/entity/post_entity.dart';
import 'package:meta_transaction/entity/reply_entity.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/util/dio_manager.dart';
import 'package:meta_transaction/util/time_util.dart';


///编写帖子相关的请求方法
class PostService{

  static Future<bool> uploadPost(String title, String content, List<MultipartFile> mSubmitFileList) async{
       bool res = false;
       String token = await PreferencesDB().getUserToken();
       FormData form = FormData.fromMap({
         "title": title,
         "content": content,
         "file": mSubmitFileList
        });
       Map<String,String> header = {
         "Content-Type": "multipart/form-data",
         "token": token,
       };
        //上传帖子标题和内容
        await DioManager.instance.post(API.UPLOAD_POST, form, header,
                (data) {
           CommonToast.showToast("上传成功");
           res = true;
         }, (error){
           CommonToast.showToast(error);
        });
        return res;
      }


  static Future<List<PostEntity>> getMyPostList(int pageNum) async{
     List<PostEntity> res = [];
     String token = await PreferencesDB().getUserToken();
     Map<String,String> params = {
       "pageSize": API.pageSize.toString(),
       "pageNum": pageNum.toString(),
     };
     await DioManager.instance.get(API.GET_MY_POST_LIST, params,{"token": token}, (data){
       for(Map item in data){
         PostEntity post = PostEntity();
         post.pid = item["pid"].toString();
         post.title = item["title"] ?? "";
         post.time = timestampToDate(item["time"]);
         post.images = item["images"] ?? "";
         post.content = item["content"];
         post.creatorAvatar = item["creatorAvatar"] ?? "";
         post.creatorId = item["creatorId"].toString();
         post.creatorName = item["creatorName"] ?? "";
         post.commentNum = item["commentNum"];
         post.favoriteNum = item["favoriteNum"];
         post.hot = item["hot"];
         post.status = item["status"];
         debugPrint(item.toString());
         res.add(post);
       }
     }, (error){

     });
     return res;
  }

  static Future<bool> deletePost(String pid) async{
    bool res = false;
     Map<String,String> params = {
       "pid": pid,
     };
     String token = await PreferencesDB().getUserToken();
     await DioManager.instance.get(API.DEL_POST, params, {"token": token}, (data){
       res = true;
     }, (error){

     });
    return res;
  }

  ///这里只根据时间获取帖子列表
  static Future<List<PostEntity>> getPostList(int pageNum, String type) async {

      Map<String,String> params = {
        "pageSize": API.pageSize.toString(),
        "pageNum": pageNum.toString(),
      };
      List<PostEntity> postList = [];
      String url = "";
      switch(type){
        case "time": url = API.GET_POST_BY_TIME; break;
        case "hot": url = API.GET_POST_BY_HOT; break;
        case "favorite": url = API.GET_POST_BY_FAVORITE; break;
      }
      await DioManager.instance.get(url,params,{}, (data){
        ///包装帖子实体类
        for(Map item in data){
          PostEntity post = PostEntity();
          post.pid = item["pid"].toString();
          post.title = item["title"] ?? "";
          post.time = timestampToDate(item["time"]);
          post.images = item["images"] ?? "";
          post.content = item["content"];
          post.creatorAvatar = item["creatorAvatar"] ?? "";
          post.creatorId = item["creatorId"].toString();
          post.creatorName = item["creatorName"] ?? "";
          post.commentNum = item["commentNum"];
          post.favoriteNum = item["favoriteNum"];
          post.hot = item["hot"];
          post.status = item["status"];
          postList.add(post);
        }
      },(error){
        CommonToast.showToast(error);
      });
      return postList;
  }

  static Future<List<PostEntity>> getTopicList(String key, int pageNum) async{
    List<PostEntity> res = [];
    Map<String,String> params = {
      "pageSize": API.pageSize.toString(),
      "pageNum": pageNum.toString(),
      "key": key,
    };
    await DioManager.instance.get(API.GET_POST_BY_KEY,params,{}, (data){
      ///包装帖子实体类
      for(Map item in data){
        PostEntity post = PostEntity();
        post.pid = item["pid"].toString();
        post.title = item["title"] ?? "";
        post.time = timestampToDate(item["time"]);
        post.images = item["images"] ?? "";
        post.content = item["content"];
        post.creatorAvatar = item["creatorAvatar"] ?? "";
        post.creatorId = item["creatorId"].toString();
        post.creatorName = item["creatorName"] ?? "";
        post.commentNum = item["commentNum"];
        post.favoriteNum = item["favoriteNum"];
        post.hot = item["hot"];
        post.status = item["status"];
        res.add(post);
      }
    },(error){
      CommonToast.showToast(error);
    });
    return res;
  }

  static Future<void> addHot(String pid) async {

    Map<String, String> params = {
      "pid": pid,
    };
    await DioManager.instance.get(API.MODIFY_HOT,params,{},(data){

    },(error){

    });

  }


  static Future<bool> doFavorite(String pid) async {
    bool res = false;
    String token = await PreferencesDB().getUserToken();

    FormData data = FormData.fromMap({
      "pid": pid,
    });

    Map<String,String> header = {
      "token": token,
    };
    await DioManager.instance.post(API.DO_FAVORITE, data, header, (data){
      res = true;
    }, (error){

    });
    return res;
  }

  static Future<bool> isFavorite(String pid, String flag) async{
    bool res = false;
    String token = await PreferencesDB().getUserToken();
    Map<String,String> params = {
      "pid": pid,
      "flag": flag,
    };
    Map<String,String> header = {
      "token": token,
    };
    
    await DioManager.instance.get(API.IS_FAVORITE, params, header, (data){
      res = true;
    }, (error){

    });
    return res;
  }

  ///获取帖子的评论列表
  static Future<List<CommentEntity>> getCommentList(String pid) async{
    Map<String,String> map = {"pid" : pid};
    List<CommentEntity> res = [];
    await DioManager.instance.get(API.GET_COMMENT_LIST, map, {}, (data){
      for(Map item in data){
        Map comment = item["comment"];
        CommentEntity commentItem = CommentEntity();
        commentItem.cid = comment["cid"].toString();
        commentItem.content = comment["content"];
        commentItem.nickname = comment["creatorName"] ?? "";
        commentItem.avatar = comment["creatorAvatar"] ?? "";
        commentItem.uid = comment["creatorId"];
        commentItem.favoriteNum = comment["favoriteNum"] ?? 0;
        commentItem.time = timestampToDate(comment["time"]);

        List<ReplyEntity>  replyList = [];
        ///获取回复列表
        for(Map reply in item["replies"]){
           ReplyEntity replyItem = ReplyEntity();
           replyItem.rid = reply["rid"].toString();
           replyItem.favoriteNum = reply["favoriteNum"] ?? 0;
           replyItem.time = timestampToDate(reply["time"]);
           replyItem.nickname = reply["creatorName"] ?? "";
           replyItem.avatar = reply["creatorAvatar"] ?? "";
           replyItem.uid = reply["creatorId"];
           replyItem.content = reply["content"];
           replyList.add(replyItem);
        }
        commentItem.replyList = replyList;
        res.add(commentItem);
      }

    }, (error){
      CommonToast.showToast(error);
    });
    return res;
  }

  ///评论帖子
  static Future<bool> doComment(String pid, String content) async{
    bool res = false;
    Map data = {
      "pid": pid,
      "content": content,
    };
    String token = await PreferencesDB().getUserToken();
    debugPrint(token);
    await DioManager.instance.post(API.DO_COMMENT, data, {"token": token}, (data){
      res = true;
    },(error){

    });
    return res;
  }




  ///回复评论
  static Future<bool> doReply(String cid, String content) async{
    bool res = false;
    Map data = {
      "cid": cid,
      "content": content,
    };
    String token = await PreferencesDB().getUserToken();
    await DioManager.instance.post(API.DO_REPLY, data, {"token": token}, (data){
      res = true;
    },(error){

    });
    return res;
  }

  ///删除评论
  static Future<bool> delComment(String cid) async{
    bool res = false;
    FormData data = FormData.fromMap({
      "cid": cid,
    });
    String token = await PreferencesDB().getUserToken();
    await DioManager.instance.post(API.DEL_COMMENT, data, {"token": token}, (data){
      res = true;
    }, (error){

    });
    return res;
  }



  ///根据Id删除回复
  static Future<bool> delReply(String rid) async{
    bool res = false;
    FormData data = FormData.fromMap({
      "rid": rid,
    });
    String token = await PreferencesDB().getUserToken();
    await DioManager.instance.post(API.DEL_REPLY, data, {"token": token}, (data){
      res = true;
    }, (error){

    });
    return res;

  }


}