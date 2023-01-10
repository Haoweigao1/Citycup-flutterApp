import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta_transaction/index.dart';
import 'package:meta_transaction/widgets/will_pop_scope_route/will_pop_scope_route.dart';

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
        title: '元小易',  //这个title只有在任务管理的时候会有用
        theme: ThemeData(
            primarySwatch: Colors.lightBlue,
        ),
        home: const WillPopScopeRoute(child: Tabs())
      );
  }

}

