import 'package:flutter/material.dart';


class InfoPage extends StatefulWidget{
  const InfoPage({super.key});
  @override
  State<StatefulWidget> createState() => _InfoPageState();

}

class _InfoPageState extends State<InfoPage>{


  @override
  Widget build(BuildContext context) {
    return Container(
      child:const Center(
         child: Text("这是资讯页面"),
      )
    );
  }

}