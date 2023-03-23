import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/app_theme.dart';




class CallUsPage extends StatelessWidget{

  const CallUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Scaffold(
       appBar: AppBar(
         title: const Text("联系我们"),
         centerTitle: true,
         backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
             : Theme.of(context).primaryColor,

       ),
       body: const SafeArea(child: CallUsBody()),
     );
  }


}

class CallUsBody extends StatefulWidget{

  const CallUsBody({super.key});

  @override
  State<StatefulWidget> createState() => _CallUsBodyState();

}

class _CallUsBodyState extends State<CallUsBody>{

  @override
  Widget build(BuildContext context) {
     return Padding(
         padding: EdgeInsets.all(20.w),
         child: Container(
           width: double.infinity,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.all(Radius.circular(20.w)),
           ),

         ),
     );
  }


}