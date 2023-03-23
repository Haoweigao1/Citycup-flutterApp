import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta_transaction/pages/Info/Info_page.dart';
import 'package:meta_transaction/pages/community/community_page.dart';

import 'package:meta_transaction/pages/home/home_page.dart';
import 'package:meta_transaction/pages/profile/common_action_pages/login_page.dart';
import 'package:meta_transaction/pages/profile/common_action_pages/modify_info_page.dart';
import 'package:meta_transaction/pages/profile/common_action_pages/register_page.dart';
import 'package:meta_transaction/pages/profile/copyright_items/copyright_protect.dart';
import 'package:meta_transaction/pages/profile/other_items/call_us_page.dart';
import 'package:meta_transaction/pages/profile/other_items/my_follow_page.dart';
import 'package:meta_transaction/pages/profile/other_items/my_message_page.dart';
import 'package:meta_transaction/pages/profile/other_items/post_list_manage_page.dart';
import 'package:meta_transaction/pages/profile/other_items/view_history_page.dart';
import 'package:meta_transaction/pages/profile/profile_page.dart';
import 'package:meta_transaction/pages/search_page.dart';
import 'package:meta_transaction/pages/test_page.dart';
import '../pages/community/upload_post_page.dart';
import '../pages/not_found_page.dart';
import '../pages/profile/copyright_items/copyright_detect.dart';
import '../pages/profile/copyright_items/copyright_register.dart';
import '../pages/profile/other_items/digital_work_donate_page.dart';
import '../pages/webview/webview_page.dart';
import '../widgets/will_pop_scope_route/will_pop_scope_route.dart';


class Routers{

  static String home = "/";   //主页面

  static String test = "/test";

  static String profile = "/profile";  //个人中心页面
  static String info= "/info";      //资讯页面
  static String modifyInfo = "/modifyInfo"; //修改个人信息也页面
  static String community = "/community";  //社区页面
  static String login = "/login";    //登录
  static String register = "/register";  //注册
  static String webView = "/webView";  //webView页面
  static String search = "/search"; //搜索页面
  static String uploadPost = "/uploadPost"; //发布话题页面
  static String postManage = "/postManage"; //个人话题管理
  static String newsHistory = "/newsHistory"; //浏览历史
  static String copyrightRegister = "/copyrightRegister"; //版权登记
  static String copyrightDetect = "/copyrightDetect";
  static String copyrightProtect = "/copyrightProtect";

  static String callUs = "/callUs";
  static String digitalWorkDonate = "/digitalWorkDonate";
  static String myFollow = "/myFollow";
  static String myMessage = "/myMessage";


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
    router.define(webView, handler: webViewHandler, transitionType: TransitionType.fadeIn);
    router.define(search,handler: searchHandler,transitionType: TransitionType.fadeIn);
    router.define(uploadPost, handler: uploadPostHandler,transitionType: TransitionType.fadeIn);

    router.define(test, handler: testHandler, transitionType: TransitionType.fadeIn);
    router.define(modifyInfo, handler: modifyInfoHandler, transitionType: TransitionType.fadeIn);
    router.define(postManage, handler: postManageHandler,transitionType: TransitionType.fadeIn);
    router.define(newsHistory, handler: historyHandler, transitionType: TransitionType.fadeIn);
    router.define(copyrightRegister, handler: copyrightRegisterHandler,transitionType: TransitionType.fadeIn);
    router.define(copyrightDetect, handler: copyrightDetectHandler, transitionType: TransitionType.fadeIn);
    router.define(copyrightProtect, handler: copyrightProtectHandler, transitionType: TransitionType.fadeIn);

    router.define(callUs, handler: callUsHandler, transitionType: TransitionType.fadeIn);
    router.define(digitalWorkDonate, handler: digitalWorkDonateHandler, transitionType: TransitionType.fadeIn);
    router.define(myFollow, handler: myFollowHandler, transitionType: TransitionType.fadeIn);
    router.define(myMessage, handler: myMessageHandler, transitionType: TransitionType.fadeIn);
  }

  static final Handler testHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const TestPage();
      });

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

  static final Handler webViewHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return WebViewPage(url: params["url"].first,title: params["title"].first);
      });
  static final Handler searchHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const SearchPage();
      });
  static final Handler uploadPostHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const UploadPostPage();
      }
  );

  static final Handler modifyInfoHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const ModifyInfoPage();
      }
  );

  static final Handler postManageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const PostManagePage();
      }
  );

  static final Handler historyHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return ViewHistoryPage();
      }
  );

  static final Handler copyrightRegisterHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CopyrightRegisterPage();
      }
  );

  static final Handler copyrightDetectHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CopyrightDetectPage();
      }
  );

  static final Handler copyrightProtectHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CopyrightProtectPage();
      }
  );

  static final Handler callUsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CallUsPage();
      }
  );

  static final Handler digitalWorkDonateHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const DigitalDonatePage();
      }
  );

  static final Handler myFollowHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const MyFollowPage();
      }
  );

  static final Handler myMessageHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const MyMessagePage();
      }
  );
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

