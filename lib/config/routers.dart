import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta_transaction/pages/communityPageGroup/communityPage.dart';
import 'package:meta_transaction/pages/copyrightServicePageGroup/copyrightServicePage.dart';
import 'package:meta_transaction/pages/homePageGroup/homePage.dart';
import 'package:meta_transaction/pages/profilePageGroup/commonActionPages/login.dart';
import 'package:meta_transaction/pages/profilePageGroup/commonActionPages/register.dart';
import 'package:meta_transaction/pages/profilePageGroup/profilePage.dart';


class Routers{
  static String root = "/";
  static String home = "/home";
  static String profile = "/profile";
  static String copyrightService= "/copyrightService";
  static String community = "/community";
  static String login = "/login";
  static String register = "/register";

  static void configureRoutes(FluroRouter router){
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          throw Exception("router not define");
        });

    router.define(home, handler:homeHandler);
    router.define(copyrightService,handler: copyrightHandler);
    router.define(community, handler: communityHandler);
    router.define(profile,handler:profileHandler);
    router.define(login,handler: loginHandler,transitionType: TransitionType.inFromBottom);
    router.define(register,handler: registerHandler,transitionType: TransitionType.inFromLeft);

  }


  static Handler homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
         return const HomePage();
      });

  static Handler copyrightHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CopyrightServicePage();
      });

  static Handler communityHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const CommunityPage();
      });

  static Handler profileHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const ProfilePage();
      });

  static Handler loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const LoginPage();
      });

  static Handler registerHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return const RegisterPage();
      });



}

