import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return Container(
        child:const Center(
          child: Text("这是个人中心页"),
        )
    );
  }

}