import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/title_bar/search_bar.dart';

import '../theme/app_theme.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});
  @override
  State<StatefulWidget> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage>{


  @override
  Widget build(BuildContext context) {

    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchBar(
           title: '',
           hintVal: '输入商品名称或哈希值',
           goBackCallback: (){
              Navigator.pop(context);
           },
           submitCallback: (val){
              debugPrint("搜索内容为$val");
           },
        ),
        backgroundColor: isDarkMode(context)
            ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),

      body: const Center(
        child: Text("这是搜索页"),
      ),
    );
  }

}