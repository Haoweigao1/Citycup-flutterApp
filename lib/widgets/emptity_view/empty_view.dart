

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';
import '../../theme/app_theme.dart';

class EmptyView extends StatelessWidget{

  final double height;

  const EmptyView({super.key, required this.height});



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
     return  Container(
       width: double.infinity,
       height: height,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20.w)),
         color: Colors.white,
       ),
       child: Center(
         child: Image(
           image: const AssetImage("${Constant.IMAGE_PATH}empty.jpg"),
           width: 300.w,
         ),
       ),

     );
  }


}