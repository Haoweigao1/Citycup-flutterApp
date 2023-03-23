

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_theme.dart';


///商品详情页面

class GoodsDetailPage extends StatelessWidget{

  const GoodsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Scaffold(
       appBar: AppBar(
         title: const Text("藏品详情"),
         backgroundColor: isDarkMode(context)
             ? Theme.of(context).primaryColor.withAlpha(155)
             : Theme.of(context).primaryColor,
         centerTitle: true,
       ),
       body: const SafeArea(child: GoodsDetailBody()),
     );
  }


}

class GoodsDetailBody extends StatefulWidget{

  const GoodsDetailBody({super.key});

  @override
  State<StatefulWidget> createState() => _GoodsDetailState();

}

class _GoodsDetailState extends State<GoodsDetailBody>{


  @override
  Widget build(BuildContext context) {
     return  CustomScrollView(


     );
  }


}