import 'package:flutter/material.dart';
import 'package:meta_transaction/constant/constant.dart';
import 'package:meta_transaction/pages/communityPageGroup/communityPage.dart';
import 'package:meta_transaction/pages/copyrightServicePageGroup/copyrightServicePage.dart';
import 'package:meta_transaction/pages/profilePageGroup/profilePage.dart';
import 'package:meta_transaction/pages/homePageGroup/homePage.dart';


//导航tab对应页面列表
List<Widget> pagesList = [
  const HomePage(),
  const CopyrightServicePage(),
  const CommunityPage(),
  const ProfilePage(),
];

//底部导航栏item
List<BottomNavigationBarItem> barItemList = [
  const BottomNavigationBarItem(label: Constant.TAB_HOME, icon: Icon(Icons.home)),
  const BottomNavigationBarItem(label: Constant.TAB_COPYRIGHT, icon: Icon(Icons.book)),
  const BottomNavigationBarItem(label: Constant.TAB_COMMUNITY, icon: Icon(Icons.people_alt)),
  const BottomNavigationBarItem(label: Constant.TAB_PROFILE, icon: Icon(Icons.account_circle)),
];


class Tabs extends StatefulWidget{
  const Tabs({super.key});

  @override
  State<StatefulWidget> createState() => _TabsState();

}

class _TabsState extends State<Tabs>{

  int _curIndex = 0; // 标识当前页面的下标
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("meta_transaction"),
      ),
      body: pagesList[_curIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
          onTap: (int index){ setState(() {
            _curIndex = index;
          });},
          items: barItemList,
          type: BottomNavigationBarType.fixed,
      ),
    );
  }

}