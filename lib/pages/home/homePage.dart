import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/titleBar/searchBar.dart';
import '../../config/application.dart';
import '../../constant/constant.dart';
import '../../theme/app_theme.dart';


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
      body: const SafeArea(child: HomePageBody())

    );

  }



}

class HomePageBody extends StatefulWidget{

  const HomePageBody({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageBodySate();


}


class _HomePageBodySate extends State<HomePageBody>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: TextButton(
          onPressed: () { Application.router.navigateTo(context, "search"); },
          child: const Text("跳转到搜索"),
        ),
      )
    );
  }


}