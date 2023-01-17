import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/constant/constant.dart';
import 'package:meta_transaction/pages/Info/InfoPage.dart';
import 'package:meta_transaction/pages/community/communityPage.dart';
import 'package:meta_transaction/pages/profile/profilePage.dart';
import 'package:meta_transaction/pages/home/homePage.dart';
import 'package:meta_transaction/theme/app_theme.dart';
import 'package:remixicon/remixicon.dart';



class Tabs extends StatefulWidget{
  const Tabs({super.key});

  @override
  State<StatefulWidget> createState() => _TabsState();

}

class _TabsState extends State<Tabs> with TickerProviderStateMixin{

  int _curIndex = 0; // 标识当前页面的下标
  late TabController _pageController;

  final double _tabIconSize = 20.sp;

  //导航tab对应页面列表
  List<Widget> pagesList = [
    const HomePage(),
    const InfoPage(),
    const CommunityPage(),
    const ProfilePage(),
  ];


  @override
  void initState() {
    super.initState();
    /// Tab控制
    _pageController = TabController(
      initialIndex: _curIndex,
      length: pagesList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    /// Tab控制
    _pageController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    ThemeData appTheme = Theme.of(context);
    Color themeColor = isDarkMode(context)
    ? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;
    return Scaffold(

        backgroundColor: Theme.of(context).tabBarTheme.labelColor,
        body: IndexedStack(
          index: _curIndex,
          children: pagesList,
        ),
        bottomNavigationBar:DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
              appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
            ]),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),
            ],
          ),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                /// 菜单
                TabBar(
                  // 震动或声音反馈
                  enableFeedback: true,
                  controller: _pageController,
                  indicatorColor: Colors.transparent,
                  labelStyle: TextStyle(
                    height: 0.5.h,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    height: 0.5.h,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  labelColor: themeColor,
                  tabs: [
                    /// 菜单
                    Tab(
                        text: Constant.TAB_HOME,
                        icon: Icon(Remix.home_3_line,
                            size: _tabIconSize)
                    ),
                    Tab(text: Constant.TAB_Info,
                        icon: Icon(Remix.file_list_3_line,
                            size: _tabIconSize)
                    ),
                    Tab(text: Constant.TAB_COMMUNITY,
                        icon: Icon(Remix.group_line,
                            size: _tabIconSize)
                    ),
                    Tab(text: Constant.TAB_PROFILE,
                        icon: Icon(Remix.user_line,
                            size: _tabIconSize)
                    )
                  ],
                  onTap: (value) {
                    setState(() {
                      _curIndex = value;
                    });
                  },
                ),

              ],
            ),
          ),
        ),

    );
  }

}




// final dio = Dio()..interceptors.add(ApiInterceptor());
//
// class ApiInterceptor extends InterceptorsWrapper {
//
//   @override
//   void onError(DioError err) {
//     super.onError(err);
//     int? statusCode = err.response?.statusCode;
//     if (statusCode == 401) {
//       // 触发登出事件
//       EventBus.instance.commit(EventKeys.logout);
//     }
//   }
// }
