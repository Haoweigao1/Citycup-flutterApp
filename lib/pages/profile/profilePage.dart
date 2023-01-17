import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:meta_transaction/constant/constant.dart';
import 'package:meta_transaction/pages/profile/menuScreen/menuScreen.dart';
import 'package:meta_transaction/widgets/animation/pressAnimation.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../model/application/applicationViewModel.dart';
import '../../theme/app_theme.dart';


class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin{
  ///保持页面状态，否则每次切换tab都会重新初始化
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
              title: const Text("我的"),
              backgroundColor: isDarkMode(context)
                  ? Theme.of(context).primaryColor.withAlpha(155)
                  : Theme.of(context).primaryColor
          ),
          endDrawer: const Drawer(
            child: MenuScreenRight(),
          ),

        )
    );
  }

}


class ProfilePageBody extends StatefulWidget{
  const ProfilePageBody({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageBodyState();

}

class _ProfilePageBodyState extends State<ProfilePageBody>{
  /// 默认状态 为关闭
  ValueNotifier<DrawerState> drawerState = ValueNotifier(DrawerState.closed);

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier ?? drawerState,
      builder: (_, state, child) {
        debugPrint("外层菜单状态：$state");
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constant.TAB_PROFILE),
          actions: <Widget>[
            AnimatedPress(
                child:IconButton(
                    onPressed: (){  ZoomDrawer.of(context)?.toggle.call(); },
                    icon: Icon(Remix.menu_line,size: 24.sp)))

          ],
        ),
      ),
    );

  }

}






