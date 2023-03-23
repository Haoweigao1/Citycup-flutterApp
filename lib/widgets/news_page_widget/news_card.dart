
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/db/sharedPreference_db.dart';
import 'package:meta_transaction/util/common_util.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';

import '../../config/application.dart';
import '../../theme/app_theme.dart';

class NewsCard extends StatelessWidget{

  final String image;
  final String url;
  final String summary;
  final String source;
  final DateTime time;

  const NewsCard({super.key, 
    required this.image, 
    required this.url,
    required this.summary, 
    required this.source, 
    required this.time
  });

  
  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    
    return AnimatedPress(
      child: GestureDetector(
        onTap: (){
          ///跳转到新闻网页
          PreferencesDB().addNewsHistory("$summary|$url");
          Application.navigateTo(context, "webView" ,params: {
            "title": summary,
            "url": url
          });
        },
        child: Container(
            width: double.infinity,
            //height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.w,bottom: 10.w),
              child: Row(
                children: [
                  ///新闻的网络图片
                  SizedBox(
                    width: 80.w,
                    height: 80.w,
                    child: Image.network(image, width: 80.w,),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///展示新闻的摘要
                      SizedBox(
                        width: 220.w,
                        child: Text(summary, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 220.w,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(source, style: TextStyle(fontSize: 11.sp, color: Colors.grey),),
                            SizedBox(width: 30.w,),
                            Text(parseTimeForNews(time),style: TextStyle(fontSize: 11.sp, color: Colors.grey),)
                          ],
                        ),
                      )
                    ],
                  )

                ],
              ),
            )
        ),
      )
    );

  }

}