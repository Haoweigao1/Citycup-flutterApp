import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/db/sharedPreference_db.dart';
import 'package:meta_transaction/pages/profile/menu_screen/item_pages/setting_theme.dart';
import 'package:meta_transaction/service/user_service.dart';
import 'package:meta_transaction/theme/app_theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:provider/provider.dart';

import '../../../config/application.dart';
import '../../../model/application/applicationViewModel.dart';
import '../../../widgets/animation/press_animation.dart';
import '../../../widgets/show_modal_bottom_detail/show_modal_bottom_detail.dart';


class MenuScreenRight extends StatelessWidget {
  const MenuScreenRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        return Scaffold(
          backgroundColor: isDarkMode(context)
              ? Theme.of(context).primaryColor.withAlpha(155)
              : Theme.of(context).primaryColor,
          body: GestureDetector(
            child: SafeArea(
              child: MenuScreenRightBody(viewModel: applicationViewModel,),
            ),
          ),
        );
      },
    );
  }
}

class MenuScreenRightBody extends StatefulWidget {

  final ApplicationViewModel viewModel;

  const MenuScreenRightBody({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuScreenRightBodyState();
}

class _MenuScreenRightBodyState extends State<MenuScreenRightBody>{

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 50.w,
                bottom: 20.w,
                left: 24.w,
                right: 24.w,
              ),
              child: const Header(),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 24.w,
                left: 24.w,
                right: 24.w,
              ),
              child: const Menu(),
            ),
            Padding(
                padding: EdgeInsets.only(
                  top: 24.w,
                  left: 36.w,
                  right:24.w,
                ),
                child: Consumer<ApplicationViewModel>(
                  builder: (_, applicationViewModel, child) {
                    return AnimatedPress(
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(color: widget.viewModel.loginState? Colors.red: Colors.white)),
                              minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                          ),
                          onPressed: (){
                            if(widget.viewModel.loginState){
                              UserService.logout();
                              setState(() {
                                widget.viewModel.setLoginState(false);
                              });
                            }else{
                              ///跳转到登录页
                              Application.router.navigateTo(context, 'login');
                            }
                          },

                          child: Text(widget.viewModel.loginState? '退出': '登录',
                              style: TextStyle(color: widget.viewModel.loginState? Colors.red: Colors.white,
                                  fontSize: 15.sp,fontWeight: FontWeight.w300)),
                        )
                    );
                  },
                )

            )
          ],
        ),
      ],
    );
  }



}

/// 头部
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: "关闭侧栏",
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.sp),
              child: Image.asset(
                "assets/images/logo-removebg.png",
                width: 70.w,
                height: 70.w,
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              "元小易",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel: "",
            ),
          ),
        ],
      ),
    );
  }
}

/// 菜单
class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  static final _titleTextSize = 14.sp;
  static final _titleIconSize = 20.sp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        MenuList(
          icon: Icon(
            Remix.bubble_chart_line,
            size: _titleIconSize,
          ),
          title: Text(
            "主题",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingTheme(),
            );
          },
        ),


        MenuList(
          icon: Icon(
            Remix.heart_3_line,
            size: _titleIconSize,
          ),
          title: Text(
             "关于",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   Routes.transformParams(
            //     router: Routes.webViewPage,
            //     params: [
            //       ValueConvert("https://github.com/AmosHuKe/Mood-Example")
            //           .encode()
            //     ],
            //   ),
            // );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.settings_2_line,
            size: _titleIconSize,
          ),
          title: Text(
            "设置",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: (){

          },
        ),

        // /// 插画
        // BlockSemanticsToDrawerClosed(
        //   child: Container(
        //     padding: EdgeInsets.only(top: 0.w),
        //     child: Image.asset(
        //       "assets/images/woolly/woolly-comet-2.png",
        //       width: 240.w,
        //     ),
        //   ),
        // ),

      ],
    );
  }
}

/// 菜单列表
class MenuList extends StatelessWidget {
  const MenuList({
    Key? key,
    this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  // 图标
  final Widget? icon;
  // 标题
  final Widget title;
  // 点击事件
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlockSemanticsToDrawerClosed(
      child: AnimatedPress(
        child:  ListTile(
          leading: icon,
          title: title,
          textColor: Colors.white,
          iconColor: Colors.white,
          minLeadingWidth: 0.w,
          horizontalTitleGap: 28.w,
          onTap: onTap,
        ),
      )

    );
  }
}

/// 侧栏关闭状态下就不显示语义
class BlockSemanticsToDrawerClosed extends StatelessWidget {
  const BlockSemanticsToDrawerClosed({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// 默认状态 为关闭
    ValueNotifier<DrawerState> drawerState = ValueNotifier(DrawerState.closed);
    return ValueListenableBuilder<DrawerState>(
      valueListenable: drawerState,
      builder: (_, state, child) {
        return BlockSemantics(
          blocking: state == DrawerState.closed,
          child: child,
        );
      },
      child: child,
    );
  }
}
