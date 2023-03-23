

//处理用户登录，注册,登出等动作



import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta_transaction/db/sharedPreference_db.dart';
import 'package:meta_transaction/model/application/applicationViewModel.dart';
import 'package:meta_transaction/model/user_info.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/util/dio_manager.dart';

import '../api/api.dart';

class UserService{

  ///登录
  static Future<bool> login(String email, String password, UserInfo userInfo,ApplicationViewModel viewModel) async{
      bool res = false;
      String token = "";
      Map params = {"email": email, "password": password};
      await DioManager.instance.post(API.LOGIN, params, {}, (data) {
      userInfo.email = data['email'];
      userInfo.token = data['token'];
      userInfo.avatar = data['avatar'] ?? "";
      userInfo.description = data['description'] ?? "";
      userInfo.nickname = data['nickname'] ?? "";
      userInfo.phone = data['phone'] ?? "";
      userInfo.hash = data['hash'] ?? "";
      userInfo.uid = data['uid'];
      userInfo.gender = data['gender'] == null? "": data["gender"].toString();
      token = data["token"];
      viewModel.setLoginState(true);
      res = true;
      debugPrint("登录成功!");
    }, (error) {
      CommonToast.showToast(error);
    });
      await PreferencesDB().setUserToken(token);
      return res;
  }

  ///登出
  static void logout() async {
    String token = await PreferencesDB().getUserToken();
    DioManager.instance.get(API.LOGOUT, {}, { "token": token }, (data) async {
      ///本地将token删除
      await PreferencesDB().setUserToken("default");
      CommonToast.showToast("登出成功!");
    }, (error){
      CommonToast.showToast(error);
    });
  }


  ///注册
  static void register(String email, String password, String code){
    Map params = {"email": email, "password": password, "code": code};
    DioManager.instance.post(API.REGISTER, params,{}, (data){
      CommonToast.showToast("注册成功!");
    }, (error){
      CommonToast.showToast(error);
    });
  }

  static Future getMyInfo(UserInfo userInfo) async{
    String token = await PreferencesDB().getUserToken();
    DioManager.instance.get(API.GET_INFO,{},{"token": token}, (data){
      userInfo.uid = data["uid"];
      userInfo.avatar = data["avatar"] ?? "";
      userInfo.hash = data["hash"] ?? "";
      userInfo.nickname = data["nickname"] ?? "";
      userInfo.email = data["email"] ?? "";
      userInfo.gender = data['gender'] == null? "": data["gender"].toString();
      userInfo.description = data["description"] ?? "";
      userInfo.phone = data["phone"] ?? "";
    }, (error){

    });

  }

  ///请求发送邮箱验证码
  static void sendCode(String email){
    Map<String,String> queryParams = {"email": email};
    DioManager.instance.get(API.SEND_CODE, queryParams,{}, (data){
      CommonToast.showToast("已成功发送验证码,请前往邮箱查看");
    }, (error){
      CommonToast.showToast(error);
    });
  }


  static Future<bool> modifyInfo(MultipartFile? avatar, String nickname,
      String gender, String phone, String description) async {
    bool res1 = false;
    bool res2 = false;
    String token = await PreferencesDB().getUserToken();
    if(avatar != null) {
      FormData data = FormData.fromMap({
        "avatar": avatar,
      });
      await DioManager.instance.post(
          API.UPLOAD_AVATAR, data, {"token": token}, (data) {
        res1 = true;
      }, (error) {

      });
    }else{
      res1 = true;
    }
    switch(gender){
      case "女": gender = "0"; break;
      case "男": gender = "1"; break;
      default: gender = "2";
    }
    Map<String,String> info = {
      "nickname": nickname,
      "gender": gender,
      "phone": phone,
      "description": description,
    };
    await DioManager.instance.post(API.MODIFY_INFO, info,{"token": token}, (data){
       res2 = true;
    }, (error){

    });
    return res1 && res2;
  }





}
