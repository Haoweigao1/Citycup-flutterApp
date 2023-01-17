import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta_transaction/pages/Info/InfoPage.dart';
import 'package:meta_transaction/pages/community/communityPage.dart';

import 'package:meta_transaction/pages/home/homePage.dart';
import 'package:meta_transaction/pages/profile/commonActionPages/login.dart';
import 'package:meta_transaction/pages/profile/commonActionPages/register.dart';
import 'package:meta_transaction/pages/profile/profilePage.dart';
import 'package:meta_transaction/pages/searchPage.dart';
import 'package:meta_transaction/util/commonUtil.dart';
import '../pages/notFoundPage.dart';
import '../pages/webview/webViewPage.dart';
import '../widgets/will_pop_scope_route/will_pop_scope_route.dart';


class Routers{

  static String home = "/";   //主页面
  static String profile = "/profile";  //个人中心页面
  static String info= "/info";      //资讯页面
  static String community = "/community";  //社区页面
  static String login = "/login";    //登录
  static String register = "/register";  //注册
  static String webView = "/webView";  //webView页面
  static String search = "/search"; //搜索页面


  static void configureRoutes(FluroRouter router){
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return const NotFoundPage();
        });

    router.define(home, handler:homeHandler);
    router.define(info,handler: infoHandler);
    router.define(community, handler: communityHandler);
    router.define(profile,handler:profileHandler);
    router.define(login,handler: loginHandler,transitionType: TransitionType.fadeIn);
    router.define(register,handler: registerHandler,transitionType: TransitionType.fadeIn);
    router.define(webView, handler: webViewPageHandler, transitionType: TransitionType.fadeIn);
    router.define(search,handler: searchPageHandler,transitionType: TransitionType.inFromBottom,transitionDuration:const Duration(milliseconds: 500));

  }


  static final Handler homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
         return const WillPopScopeRoute(child: HomePage());
      });

  static final Handler infoHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const WillPopScopeRoute(child: InfoPage());
      });

  static final Handler communityHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const WillPopScopeRoute(child: CommunityPage());
      });

  static final Handler profileHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const WillPopScopeRoute(child: ProfilePage());
      });

  static final Handler loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const LoginPage();
      });

  static final Handler registerHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const RegisterPage();
      });

  static final Handler webViewPageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        var title = ValueConvert.fluroCnParamsDecode(params["title"].first);
        var url = ValueConvert.fluroCnParamsDecode(params["url"].first);
        return WebViewPage(url: url,title: title);
      });
  static final Handler searchPageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const SearchPage();
      });
  // 路由带参数
  // 在路由需要传输参数时，将参数一一对应传入，返回String
  // 例如：transformParams(router,["1","2"]) => router/1/2
  static String transformParams({
    required String router,
    required List<dynamic> params,
  }) {
    late String transform = "";
    for (int i = 0; i < params.length; i++) {
      transform += "/${params[i]}";
    }
    debugPrint("$router$transform");
    return "$router$transform";
  }

}

