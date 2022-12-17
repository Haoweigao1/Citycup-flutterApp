import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta_transaction/pages/index.dart';

import 'config/application.dart';
import 'config/routers.dart';


void main() {
  Routers.configureRoutes(Application.router);
  runApp(const MainAPP());
}


class MainAPP extends StatelessWidget{

  const MainAPP({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        //onGenerateRoute: router.generator,
        onGenerateRoute:Application.router.generator,
        title: 'Flutter Demo',  //这个title只有在任务管理的时候会有用
        theme: ThemeData(
            primarySwatch: Colors.lightBlue,
        ),
        home: const Tabs()
      );
  }

}

