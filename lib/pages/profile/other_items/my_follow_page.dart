import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/emptity_view/empty_view.dart';
import '../../../theme/app_theme.dart';


class MyFollowPage extends StatelessWidget{

  const MyFollowPage({super.key});

  @override
  Widget build(BuildContext context) {

    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("我的关注"),
        centerTitle: true,
        backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),
      body: const SafeArea(child: MyFollowBody()),
    );
  }


}


class MyFollowBody extends StatefulWidget{

  const MyFollowBody({super.key});

  @override
  State<StatefulWidget> createState() => _MyFollowBodyState();

}

class _MyFollowBodyState extends State<MyFollowBody>{

  @override
  Widget build(BuildContext context) {
     return const EmptyView(height: double.infinity);
  }

}