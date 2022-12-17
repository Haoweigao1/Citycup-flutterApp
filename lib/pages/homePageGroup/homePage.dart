import 'package:flutter/material.dart';

import '../../config/application.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{


  @override
  Widget build(BuildContext context) {
    return Container(
        child:SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text("登录"),
            onPressed: () {
               //跳转到登录页
              Application.router.navigateTo(context, 'login');
            },
          ),
        ),
    );
  }

}