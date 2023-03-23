import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/model/application/applicationViewModel.dart';
import 'package:meta_transaction/pages/community/post_list.dart';
import 'package:meta_transaction/pages/community/topic_page.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/util/common_util.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../config/application.dart';
import '../../constant/constant.dart';
import '../../db/sharedPreference_db.dart';
import '../../theme/app_theme.dart';
import '../../widgets/title_bar/search_bar.dart';

GlobalKey<PostListState> postKey = GlobalKey();

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<StatefulWidget> createState() => _CommunityPageState();

}

class _CommunityPageState extends State<CommunityPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    super.build(context);
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    Color themeColor = isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

    return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: SearchBar(
                title: Constant.TAB_COMMUNITY,
                hintVal: '输入关键词',
                navigate: (){
                  Application.router.navigateTo(context, "search");
                },
              ),

              backgroundColor: themeColor
          ),
          body: const SafeArea(child: CommunityPageBody()),
          floatingActionButton: AnimatedPress(
            child: FloatingActionButton(
              backgroundColor: themeColor,
              onPressed: () async {
                ///检测用户是否已经登录
                loginInterceptor(context, mounted);
                ///跳转到上传帖子页面
                if(mounted){ Application.navigateTo(context, "uploadPost"); }
              },
              child: Icon(Remix.add_line,size: 28.sp,),
            ),
          ),
    );


  }


}

class CommunityPageBody extends StatefulWidget{
  const CommunityPageBody({super.key});


  @override
  State<StatefulWidget> createState() => _CommunityPageBodyState();

}

class _CommunityPageBodyState extends State<CommunityPageBody> with TickerProviderStateMixin{

  GlobalKey timeKey = GlobalKey();
  GlobalKey hotKey = GlobalKey();
  GlobalKey favoriteKey = GlobalKey();

  int _curIndex = 0; // 标识当前tab展示的帖子列表种类
  late TabController _tabController;
  final double _tabIconSize = 20.sp;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    /// Tab控制
    _tabController = TabController(
      initialIndex: _curIndex,
      length: 3,
      vsync: this,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels>_scrollController.position.maxScrollExtent-40){
        switch (_curIndex) {
          case 0 :
            (timeKey.currentState as PostListState).getData();
            break;
          case 1:
            (hotKey.currentState as PostListState).getData();
            break;
          case 2:
            (favoriteKey.currentState as PostListState).getData();
            break;
          default:
            break;
        }
      }
    });

  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  Widget _getPostList(){
    switch(_curIndex){
      case 0: return  PostList(myKey: timeKey, type: "time",);
      case 1: return  PostList(myKey: hotKey, type: "hot");
      default: return  PostList(myKey: favoriteKey, type: "favorite",);
    }
  }

  Future<void> _onRefresh() async{
    await Future.delayed(const Duration(milliseconds:1500),() async {
      switch (_curIndex) {
        case 0 :
          await (timeKey.currentState as PostListState).onRefresh();
          break;
        case 1:
          await (hotKey.currentState as PostListState).onRefresh();
          break;
        case 2:
          await (favoriteKey.currentState as PostListState).onRefresh();
          break;
        default:
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> topicGroup = [
      ItemCell("metaverse.jpg", "元宇宙", (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const TopicPage(topic: "元宇宙")
        ));
      }),
      ItemCell("nft_transaction.jpeg", "nft交易", (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const TopicPage(topic: "nft")
        ));
      }),
      ItemCell("copyright_protect.png", "版权保护", (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const TopicPage(topic: "版权保护")
        ));
      }),
      ItemCell("copyright_register.jpeg", "版权登记", (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const TopicPage(topic: "版权登记")
        ));
      })
    ];

     return Consumer<ApplicationViewModel>(
         builder: (_, applicationViewModel, child) {
            return  RefreshIndicator(
                onRefresh: () => _onRefresh(),
                child:  CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      color: Colors.white,
                                      width: double.infinity,
                                      height: 40.h,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.h, left: 15.w,bottom: 10.h),
                                        child: Text("话题广场" ,
                                            style: TextStyle(fontSize: 16.sp,color: Colors.black,
                                                fontWeight: FontWeight.normal)),
                                      )
                                  ),
                                  SizedBox(
                                    height: 1.w,
                                  ),
                                  ///横向列表
                                  Container(
                                    color: Colors.white,
                                    width: double.infinity,
                                    height: 140.w,
                                    child:  SingleChildScrollView(
                                      padding: EdgeInsets.only(left: 15.w),
                                      physics: const BouncingScrollPhysics(),
                                      //设置横向滑动
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: topicGroup,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                      color: Colors.white,
                                      width: double.infinity,
                                      child: TabBar(
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
                                        labelColor: Colors.redAccent,
                                        controller: _tabController,
                                        tabs: [
                                          Tab(icon: Icon(Icons.bookmark_outline, size: _tabIconSize),
                                              text: "最新"),
                                          Tab(icon: Icon(Icons.local_fire_department_outlined, size: _tabIconSize),
                                              text: "最热"),
                                          Tab(icon: Icon(Icons.star_border_outlined, size: _tabIconSize),
                                              text: "关注"),
                                        ],
                                        padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                        onTap: (value) {
                                          ///切换栏目重新加载帖子列表数据
                                          setState(() {
                                            _curIndex = value;

                                          });
                                        },
                                      )
                                  ),
                                  ///帖子列表

                                  Padding(
                                      padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.w),
                                      child: _getPostList()
                                  )
                                ],

                              ),

                            );
                          },
                          childCount: 1
                      ),
                    )
                  ],
                ),
            );
         }
     );
  }



  Widget ItemCell(String imageName, String itemTitle, Function onClick){
    return GestureDetector(
      onTap: (){  onClick(); },
      child: AnimatedPress(
        child: Container(
          padding: EdgeInsets.all(5.w),
          width: 110.w,
          height: 115.w,
          child: Column(
            children: [
              Container(
                width: 100.w,
                height: 80.w,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft:Radius.circular(10.w),topRight:Radius.circular(10.w)),
                   image: DecorationImage(
                       image: AssetImage(Constant.IMAGE_PATH + imageName),
                       fit: BoxFit.cover,
                   )
                ),
              ),
              Container(
                height: 25.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.w),bottomRight:Radius.circular(10.w)),
                  color: const Color(0xEEEEEEEE),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child:  Row(
                    children: [
                      Icon(Icons.topic_outlined, size: 15.w, color: Colors.redAccent,),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(itemTitle, style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500),),
                    ],

                  ),
                )



              )
            ],

          ),

        ),
      ),

    );
  }


}



