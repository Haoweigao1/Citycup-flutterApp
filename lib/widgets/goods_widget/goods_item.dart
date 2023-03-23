
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/constant/constant.dart';

import '../../theme/app_theme.dart';

///数字藏品单元
class GoodsItem extends StatelessWidget{

  final String url;
  final String title;
  final double price;

  const GoodsItem({super.key,
    required this.url,
    required this.title,
    required this.price});

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Container(
       width: double.infinity,
       clipBehavior: Clip.hardEdge,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(20.w))
       ),
         child: Column(
           children: [
              ///图片
              Center(
                child: Image(
                  image: NetworkImage(url),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              ),

             Container(
               color: Colors.white,
               width: double.infinity,
               height: 95.h,
               child:  Padding(
                 padding: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 20.w, right: 20.w),
                 child: Row(
                   children: [
                     ///作品名称
                     Column(
                       children: [
                         SizedBox(height: 3.h,),
                         SizedBox(
                           width: 200.w,
                           child: Text(title , style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                         ),
                         const Spacer(),
                         SizedBox(
                           width: 200.w,
                           child: Row(
                             children: [
                               Image(image: const AssetImage("${Constant.IMAGE_PATH}logo-removebg.png"), width: 30.w,),
                               SizedBox(width: 5.w,),
                               Text("元小易", style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),)
                             ],
                           ),
                            )


                       ],
                     ),
                     
                     const Spacer(),
                     ///作品价格
                     priceText(price),
                   ],
                 )
               )
             )


           ],
         ),
       );
  }


  Widget priceText(double price){
    return Container(
       width: 70.w,
       height: 70.w,
       decoration: BoxDecoration(
         gradient: const LinearGradient(
           colors: [
            Colors.blueAccent,
            Colors.purpleAccent,
           ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
         ),
         borderRadius: BorderRadius.all(Radius.circular(10.w)),
         color: Colors.grey,
       ),
       child: Center(
         child: Text(
            "价格\n￥${price.toString()}",
           style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.white),
         ),
       ),
    );
  }

}