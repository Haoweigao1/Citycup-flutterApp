import 'package:flutter/material.dart';

class CopyrightServicePage extends StatefulWidget{
  const CopyrightServicePage({super.key});

  @override
  State<StatefulWidget> createState() => _CopyrightServiceState();

}

class _CopyrightServiceState extends State<CopyrightServicePage>{


  @override
  Widget build(BuildContext context) {
    return Container(
        child:const Center(
          child: Text("这是版权服务页"),
        )
    );
  }

}