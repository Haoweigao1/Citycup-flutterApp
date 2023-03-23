import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import '../config/application.dart';
import '../db/sharedPreference_db.dart';
import 'common_toast.dart';


/// 震动
Future<void> vibrate() async {
  Vibration.vibrate(duration: 10);
}


bool checkEmail(String input) {
   if (input.isEmpty) return false;
   // 邮箱正则
   String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
   return RegExp(regexEmail).hasMatch(input);
}

String parseTimeForNews(DateTime time){
  String res = "";
  //只要时间的年份，日期
  res += time.year.toString();
  res += "年";
  res += time.month.toString();
  res += "月";
  res += time.day.toString();
  res += "日";
  return res;

}

void loginInterceptor(BuildContext context, bool mounted) async{
  String token = await PreferencesDB().getUserToken();
  if(token == "default"){
    CommonToast.showToast("请先登录");
    if(mounted){ Application.navigateTo(context, "login"); }
    return;
  }
}


bool isCardId(String cardId){

    if (cardId.length != 18) {

     return false; // 位数不够
    }
   // 身份证号码正则
   RegExp postalCode = RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
   // 通过验证，说明格式正确，但仍需计算准确性
   if (!postalCode.hasMatch(cardId)) {
      return false;
   }
   //将前17位加权因子保存在数组里
   final List idCardList = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"];
   //这是除以11后，可能产生的11位余数、验证码，也保存成数组
   final List idCardYArray = ['1','0','10','9','8','7','6','5','4','3','2'];
   // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;
    for (int i = 0; i < 17; i ++) {
      int subStrIndex = int.parse(cardId.substring(i,i+1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
     }
     // 计算出校验码所在数组的位置
     int idCardMod = idCardWiSum % 11;
     // 得到最后一位号码
     String idCardLast = cardId.substring(17,18);
     //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
     if (idCardMod == 2){
        if (idCardLast != 'x' && idCardLast != 'X'){
           return false;
         }
     }else{
       //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
       if (idCardLast != idCardYArray[idCardMod]){
          return false;
       }
   }
   return true;

   }



/// 检测是否有权限
/// [permissionList] 权限申请列表
/// [onSuccess] 全部成功
/// [onFailed] 有一个失败
/// [goSetting] 前往设置 插件虽然提供了一个跳转设置的方法不过也可以自定义
checkPermission(
    {required List<Permission> permissionList,
      VoidCallback? onSuccess,
      VoidCallback? onFailed,
      VoidCallback? goSetting}) async {
  ///一个新待申请权限列表
  List<Permission> newPermissionList = [];

  ///遍历当前权限申请列表
  for (Permission permission in permissionList) {
    PermissionStatus status = await permission.status;

    ///如果不是允许状态就添加到新的申请列表中
    if (!status.isGranted) {
      newPermissionList.add(permission);
    }
  }

  ///如果需要重新申请的列表不是空的
  if (newPermissionList.isNotEmpty) {
    PermissionStatus permissionStatus =
    await requestPermission(newPermissionList);

    switch (permissionStatus) {

    ///拒绝状态
      case PermissionStatus.denied:
        if(onFailed != null){ onFailed(); }
        break;

    ///允许状态
      case PermissionStatus.granted:
        if(onSuccess != null){ onSuccess(); }
        break;

    /// 永久拒绝  活动限制
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        goSetting != null
            ? goSetting()
            : openAppSettings();
        break;
    }
  } else {
     if(onSuccess != null){ onSuccess(); }
  }
}

/// 获取新列表中的权限 如果有一项不合格就返回false
requestPermission(List<Permission> permissionList) async {
  Map<Permission, PermissionStatus> statuses = await permissionList.request();
  PermissionStatus currentPermissionStatus = PermissionStatus.granted;
  statuses.forEach((key, value) {
    if (!value.isGranted) {
      currentPermissionStatus = value;
      return;
    }
  });
  return currentPermissionStatus;
}





/// 内容基础加密/解密转换以及编解码
class ValueConvert {
  String value;
  ValueConvert(this.value);
  String encode() => base64Encode(utf8.encode(value));
  String decode() => utf8.decode(base64Decode(value));


  /// fluro 传递中文参数前，先转换，fluro 不支持中文传递
  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(const Utf8Encoder().convert(originalCn));
  }

  /// fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    encodeCn = encodeCn.substring(1,encodeCn.length - 1);
    debugPrint(encodeCn);
    var list = <int>[];
    ///字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = const Utf8Decoder().convert(list);
    return value;
  }

  /// string 转为 int
  static int string2int(String str) {
    return int.parse(str);
  }

  /// string 转为 double
  static double string2double(String str) {
    return double.parse(str);
  }

  /// string 转为 bool
  static bool string2bool(String str) {
    if (str == 'true') {
      return true;
    } else {
      return false;
    }
  }

  /// object 转为 string json
  static String object2string<T>(T t) {
    return fluroCnParamsEncode(jsonEncode(t));
  }

  /// string json 转为 map
  static Map<String, dynamic> string2map(String str) {
    return json.decode(fluroCnParamsDecode(str));
  }

}
