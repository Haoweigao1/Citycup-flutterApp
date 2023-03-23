import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/config/application.dart';
import 'package:meta_transaction/model/application/applicationViewModel.dart';
import 'package:meta_transaction/pages/profile/menu_screen/menu_screen.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:meta_transaction/widgets/emptity_view/empty_view.dart';
import 'package:provider/provider.dart';

import '../../model/user_info.dart';
import '../../theme/app_theme.dart';
import 'item_list.dart';


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
    return Scaffold(
          appBar: AppBar(
              title: const Text("我的"),
              automaticallyImplyLeading:false,
              elevation: 0,
              backgroundColor: isDarkMode(context)
                  ? Theme.of(context).primaryColor.withAlpha(155)
                  : Theme.of(context).primaryColor,

          ),
          endDrawer: const Drawer(
            child: MenuScreenRight(),
          ),
          body: const ProfilePageBody(),
    );
  }

}


class ProfilePageBody extends StatefulWidget{
  const ProfilePageBody({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageBodyState();

}

class _ProfilePageBodyState extends State<ProfilePageBody>{

  late Color themeColor;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    bool loginState = Provider.of<ApplicationViewModel>(context, listen: true).loginState;


    themeColor = isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

    ItemList itemList = ItemList(context);
    itemList.init();

    return CustomScrollView(

        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loginState? userHeader(): emptyHeader(),
                        SizedBox(height: 3.h,),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                          height: 40.h,
                          width: 750.w,
                          child:  Container(
                            margin: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h),
                            child: Text("订单管理" ,
                                style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.normal)),
                          )
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                            height: 60.h,
                            child: GridView.count(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 15.w),
                              children: List.generate(itemList.orderList.length,
                                      (index) => itemList.orderList[index]
                              ),
                            )
                        ),

                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                            height: 40.h,
                            width: 750.w,
                            child:  Container(
                              margin: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h),
                              child: Text("版权服务" ,
                                  style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.normal)),
                            )
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        ///版权服务模块
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                          height: 60.h,
                          child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              primary: false,

                              padding: EdgeInsets.only(left: 15.w),
                              children: List.generate(itemList.copyrightList.length,
                                  (index) => itemList.copyrightList[index]
                            ),
                          )
                          ),

                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                            height: 40.h,
                            width: 750.w,
                            child:  Container(
                              margin: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h),
                              child: Text("其他服务" ,
                                  style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.normal)),
                            )
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                            child: GridView.count(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 15.w),
                              children: List.generate(itemList.otherList.length,
                                      (index) => itemList.otherList[index]
                              ),
                            )
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.w)),
                              color: Colors.white,
                            ),
                            height: 40.h,
                            width: 750.w,
                            child:  Container(
                              margin: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h),
                              child: Text("我的藏品" ,
                                  style: TextStyle(fontSize: 15.sp,color: Colors.black,)),
                            )
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        EmptyView(height: 150.h),

                      ],
                    ),

                  );
                },
                childCount: 1
            ),

          )
        ],
      );


  }

  ///获取未登录状态用户信息header
  Widget emptyHeader(){

    return Container(
      height: 150.h,
      ///设置背景渐变色
      decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              themeColor,
              Color.fromRGBO(themeColor.red - 25, themeColor.green + 25, themeColor.blue - 25, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),

      child: Container(
          margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16.w),
                    ///切成圆形
                    child: ClipOval(
                      child: Image(
                          image: const AssetImage('assets/images/icon.jpeg'),
                          width: 56.w),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      ///跳转到登录页面
                      Application.navigateTo(context, "login");
                      },
                    child: SizedBox(
                      width: 200.w,
                      child: Center(
                        child: Text("请登录" ,style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                      ),
                    )
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          )
      ),
    );
  }


  Widget userHeader(){

    return Consumer<UserInfo>(
      builder: (_, userInfo, child) {
        debugPrint("用户头像${userInfo.avatar}");
        return Container(
          height: 150.h,
          ///设置背景渐变色
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor,
                  Color.fromRGBO(themeColor.red - 25, themeColor.green + 25, themeColor.blue - 25, 1)
                ],

                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),

          child: Container(
              margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16.w),
                        ///切成圆形
                        child: ClipOval(
                          child:  userInfo.avatar != ""?Image.network(userInfo.avatar, width: 56.w,height: 56.w,fit: BoxFit.cover,):
                             Image(image: const AssetImage('assets/images/icon.jpeg'), width: 56.w,height: 56.w,fit: BoxFit.cover,)
                        )
                      ),
                      Expanded(
                        flex: 100,
                        child: Container(
                          margin: EdgeInsets.only(left: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, //元素左对齐
                            children: <Widget>[
                              Text(
                                userInfo.nickname,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "hash:${userInfo.hash}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: 24.h,
                        padding: EdgeInsets.only(right: 16.w, left: 12.w),
                        child:  AnimatedPress(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
                                  minimumSize: MaterialStateProperty.all(Size(60.w, 30.w)),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                              ),
                              ///跳转进入用户信息编辑页面
                              onPressed: () {
                                Application.router.navigateTo(context, '/modifyInfo');
                              },
                              child: Text("编辑信息",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 12.sp,fontWeight: FontWeight.w300)),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ///展示用户的资产和积分
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      headItem("资产", "0"),
                      headItem("积分", "0"),
                      headItem("粉丝", "0"),
                    ],
                  )
                ],
              )
          ),
        );
      },
    );

  }


  Widget headItem(String title, String value){
    return SizedBox(
      height: 50.h,
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
            child: Center(
              child: Text(title, style: TextStyle(fontSize: 14.sp,color: Colors.white)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 15.h,
            child: Center(
              child: Text(value, style: TextStyle(fontSize: 12.sp,color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

}

