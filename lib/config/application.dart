// ignore: import_of_legacy_library_into_null_safe
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';


class Application{
  static FluroRouter router = FluroRouter();

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配,尤其中文
  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic>? params,
        bool replace = false}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = "$query&";
        }
        query += "$key=$value";
        index++;
      }
    }
    debugPrint('我是navigateTo传递的参数：$query');
    path = path + query;
    return router.navigateTo(context, path, replace: replace);
  }

}