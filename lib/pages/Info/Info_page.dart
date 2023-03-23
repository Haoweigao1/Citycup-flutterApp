import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/model/banner_model.dart';
import 'package:meta_transaction/pages/Info/news_list_page.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:provider/provider.dart';
import '../../config/application.dart';
import '../../constant/constant.dart';
import '../../entity/banner_entity.dart';
import '../../service/news_service.dart';
import '../../theme/app_theme.dart';


class InfoPage extends StatefulWidget{
  const InfoPage({super.key});
  @override
  State<StatefulWidget> createState() => _InfoPageState();

}

class _InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin{


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

    return FutureProvider<BannerModel?>(
        create: (context) => NewsService.getNewsModel(),
        initialData: null,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: isDarkMode(context)
                  ? Theme.of(context).primaryColor.withAlpha(155)
                  : Theme.of(context).primaryColor,
              title:const Text("资讯"),
            ),
            body: const InfoPageBody()

        )
    );



  }

}

class InfoPageBody extends StatefulWidget{

  const InfoPageBody({super.key});

  @override
  State<StatefulWidget> createState() => _InfoPageBodyState();

}

class _InfoPageBodyState extends State<InfoPageBody>{


   Map<String, int> map = {
     "版权保护": 1,
     "数字作品": 2,
     "元宇宙": 3,
     "nft": 4,
     "版权交易": 5,
     "人物研读": 6,
   };

   @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> columnList = [
      getColumnItem("元宇宙", "metaverse.jpg"),
      getColumnItem("nft", "nft_transaction.jpeg"),
      getColumnItem("版权保护", "copyright_protect.png"),
      getColumnItem("版权登记", "copyright_register.jpeg"),
      getColumnItem("区块链", "blockchain.jpg"),
      getColumnItem("数字作品", "digital_works.png"),
      getColumnItem("人物研读", "meta_people.jpg"),
      getColumnItem("政策概览", "policy.jpg")
    ];

    List<String> titles = [
      "元宇宙","nft","版权保护","版权登记","区块链","数字作品","人物研读","政策概览",
    ];

    List<Widget> lawList = [
      getLawItem("law_civil_code.jpg", "http://www.gov.cn/xinwen/2020-06/01/content_5516649.htm"),
      getLawItem("law_intellectual_property.jpg", "https://www.cnipa.gov.cn/art/2020/11/23/art_97_155167.html?ivk_sa=1024320u"),
      getLawItem("law_network_security.jpg", "http://www.npc.gov.cn/npc/c30834/201611/270b43e8b35e4f7ea98502b6f0e26f8a.shtml"),
      getLawItem("law_personal_information.png", "http://www.npc.gov.cn/npc/c30834/202108/a8c4e3672c74491a80b53a172bb753fe.shtml"),
    ];

     BannerModel? dataModel = context.watch<BannerModel?>();
     if(dataModel == null){
       return const Center(
         child: Text("加载中..."),
       );
     }
       ///主体采用滚动视图
     return CustomScrollView(
       slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
                   (context, index) {
                return Padding(padding: EdgeInsets.only(bottom: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       ///轮播图模块
                      AspectRatio(
                        aspectRatio:8.0 / 5.0,// 16.0 / 9.0,
                        child: Swiper(
                          indicatorAlignment: AlignmentDirectional.topEnd,
                          circular: true,
                          autoStart:true,
                          indicator: NumberSwiperIndicator(),//使用的官方的 分数下标
                          children: bannerImages(dataModel.bannerList),//这里是一个List<String>类型的参数，存放的图片Url列表
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        color: Colors.white,
                        height: 35.w,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w,top: 5.w,bottom: 5.w),
                          child: Text("推荐栏目", style: TextStyle(fontSize: 15.sp),),
                        )
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ///各个栏目
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top:10.w),
                          child:  GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.only(bottom: 5.w),
                            children: List.generate(columnList.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                   int? type = map[titles[index]];
                                   if(type != null){
                                     Navigator.push(context,
                                         MaterialPageRoute(builder: (context) =>
                                         NewsListPage(title: titles[index], type: type)));
                                   }else{
                                     CommonToast.showToast("功能正在开发中...");
                                   }

                                },
                                child: columnList[index],
                              ),
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: 5.h,
                      ),

                      ///法律课堂
                      Container(
                        width: double.infinity,
                        height: 140.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("${Constant.IMAGE_PATH}law_banner.jpeg"),
                            fit: BoxFit.fill,
                          )
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 120.h,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            //itemCount: lawList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                                int i = index % lawList.length;
                                return Row(
                                  children: [
                                    lawList[i],
                                    SizedBox(
                                      width: 5.w,
                                    )
                                  ],
                                );
                        }),
                      )
                     ]

                  ),

                 );

              },
              childCount: 1
             ),

          ),

       ],
     );
  }

   List<Widget> bannerImages(List<BannerEntity> bannerList) {
     return bannerList.map<Widget>((banner){

       return GestureDetector(
         onTap: (){
             ///跳转到webview
             debugPrint(banner.image);
             Application.navigateTo(context, "webView" ,params: {
             "title": "详情",
             "url": banner.url
             });
           },
         child: Image.network(
           banner.image,
           fit: BoxFit.cover,
         ),
       );
     }).toList();
   }

   Widget getColumnItem(String name, String imageName){
     return AnimatedPress(child: SizedBox(
         width: 100.w,
         height: 130.w,
         child: Column(
           children:[
             Container(
               width: 70.w,
               height: 70.w,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  image: DecorationImage(
                    image: AssetImage(Constant.IMAGE_PATH + imageName),
                    fit: BoxFit.cover,
                  )
               ),
             ),
             SizedBox(height: 2.w,),
             Center(
               child: Text(name, style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w500),),
             )
           ],
         ),
        )
       );
   }

   Widget getLawItem(String imageName,String url){
     return AnimatedPress(
         child: GestureDetector(
             onTap: ()=>{
               Application.navigateTo(context, "webView" ,params: {
                 "title": "",
                 "url": url,
               })
             },
             child: Container(
               width: 120.w,
               decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(Constant.IMAGE_PATH + imageName),
                     fit: BoxFit.cover,
                   )
               ),

             )
         )
     );

   }

}


class NumberSwiperIndicator extends SwiperIndicator{
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    if(itemCount>1){
      return Container(
        decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(20.w)
        ),
        margin: EdgeInsets.only(top: 10.w,right: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.w),
        child: Text("${++index}/$itemCount", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      );
    }else{
      return Container();
    }
  }
}





