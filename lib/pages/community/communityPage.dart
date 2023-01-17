import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget{
  const CommunityPage({super.key});

  @override
  State<StatefulWidget> createState() => _CommunityPageState();

}

class _CommunityPageState extends State<CommunityPage> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    return Container(
        child:const Center(
          child: Text("这是社区页"),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;

}