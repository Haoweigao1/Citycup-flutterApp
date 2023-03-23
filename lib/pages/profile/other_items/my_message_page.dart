
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/emptity_view/empty_view.dart';

import '../../../theme/app_theme.dart';

class MyMessagePage extends StatelessWidget{

  const MyMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的消息"),
        backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
        centerTitle: true
      ),
      body: const SafeArea(child: MyMessageBody()),
    );
  }


}


class MyMessageBody extends StatefulWidget{

  const MyMessageBody({super.key});

  @override
  State<StatefulWidget> createState() => _MyMessageBodyState();

}

class _MyMessageBodyState extends State<MyMessageBody>{

  @override
  Widget build(BuildContext context) {
     return const EmptyView(height: double.infinity);
  }


}