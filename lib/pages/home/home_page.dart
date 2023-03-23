import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:meta_transaction/widgets/goods_widget/goods_item.dart';
import 'package:meta_transaction/widgets/title_bar/search_bar.dart';
import 'package:provider/provider.dart';
import '../../config/application.dart';
import '../../constant/constant.dart';
import '../../model/application/applicationViewModel.dart';
import '../../theme/app_theme.dart';
import 'goods_classify.dart';


class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

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
    return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SearchBar(
              title: Constant.TAB_HOME,
              hintVal: '输入商品名称或哈希值',
              navigate: (){
                Application.router.navigateTo(context, "search");
              },
            ),
            backgroundColor: isDarkMode(context)
                ? Theme.of(context).primaryColor.withAlpha(155)
                : Theme.of(context).primaryColor
          ),
          body: const HomePageBody()
       );

  }



}

class HomePageBody extends StatefulWidget{

  const HomePageBody({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageBodySate();

}



class _HomePageBodySate extends State<HomePageBody> with TickerProviderStateMixin{


  int _curIndex = 0; // 标识当前tab展示的帖子列表种类
  late TabController _tabController;
  late Color themeColor;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: _curIndex,
        length: classify.length,
        vsync: this
    );

  }

  Future _onRefresh() async {

  }

  @override
  Widget build(BuildContext context) {
    themeColor = isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

    return Consumer<ApplicationViewModel>(
        builder: (_, applicationViewModel, child) {
          return  RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child:  CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 48.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               ///顶部tab视图
                              Container(
                                  color: Colors.white,
                                  width: double.infinity,
                                  child: TabBar(
                                    isScrollable: true,
                                    labelStyle: TextStyle(
                                      height: 1.h,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    unselectedLabelStyle: TextStyle(
                                      height: 1.h,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    labelColor: themeColor,
                                    controller: _tabController,
                                    tabs: classify,
                                    padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                    onTap: (value) {
                                      ///切换栏目重新加载帖子列表数据
                                      setState(() {
                                        _curIndex = value;

                                      });
                                    },
                                  )
                              ),
                              SizedBox(height: 5.h,),
                              ///藏品列表

                              Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                child: const AnimatedPress(

                                  child: GoodsItem(
                                      url: 'https://images.artnet.com/aoa_lot_images/139048/shepard-fairey-sun-is-shining-prints-and-multiples-zoom_500_500.jpg',
                                      title:"Sun is Shining", price: 9.9
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.w,),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                child: const AnimatedPress(

                                  child: GoodsItem(
                                      url: 'https://images.artnet.com/aoa_lot_images/139247/shepard-fairey-mandala-ornament-redgold-paintings-zoom_368_500.jpg?76e5cabdd58e47a0a81aee87b1fe9099',
                                      title:"Mandala Ornament (Red/Gold)", price: 9.9
                                  ),
                                ),
                              ),





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


}