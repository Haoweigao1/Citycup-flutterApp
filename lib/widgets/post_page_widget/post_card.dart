
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:remixicon/remixicon.dart';

import '../../theme/app_theme.dart';


///帖子卡片
class PostCard extends StatelessWidget{
  final String avatar;
  final String nickname;
  final String time;
  final String? title;
  final List<String>? images;
  final int hot;
  final int favorite;
  final int commentNum;
  final int maxImageNum;
  final Function onTap;

  const PostCard({super.key,
    required this.avatar,
    required this.nickname,
    required this.time,
    this.title,
    this.images,
    required this.hot,
    required this.favorite,
    required this.commentNum,
    this.maxImageNum = 3,
    required this.onTap         //最大展示图片数量为3
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
          onTap: (){  onTap(); },
          child: Container(
              width: double.infinity,  //横向布满整个屏幕
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.w)),
                color: Colors.white,
              ),

              child: Padding(
                padding: EdgeInsets.only(left: 15.w,right: 15.w), //主体内容与卡片边缘的间隔
                child: Column(
                  children: [
                    ///展示发帖人的头像，昵称和发帖时间
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Row(
                        children: [
                          //头像
                          ClipOval(
                            child:
                            avatar == ""? Image(
                                image: const AssetImage('assets/images/icon.jpeg'),
                                width: 45.w, fit: BoxFit.cover, height: 45.w,): Image(
                                image: NetworkImage(avatar!),
                                width: 45.w, fit: BoxFit.cover, height: 45.w,),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(nickname == ""? "无昵称": nickname ,
                            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500),),
                          //占位
                          const Spacer(),
                          Text(time, style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,
                              color: Colors.grey))
                        ],
                      ),
                    ),
                    //分割线
                    Container(
                      color: const Color(0xEEEEEEEE),
                      //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      height: 1.h,
                    ),
                    ///显示帖子的标题和部分图片
                    Padding(
                      padding: EdgeInsets.only(top:10.w,bottom: 10.w),
                      child:   SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            //标题
                            SizedBox(
                              width: double.infinity,
                              child: Text(title == null ? "": title!,
                                textAlign: TextAlign.start ,
                                style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal),
                              ),
                            ),

                            SizedBox(
                              height: 10.w,   //上下间隔
                            ),
                            ///展示图片
                            images == null? SizedBox(height: 1.w,):
                            SizedBox(
                              width: double.infinity,
                              height: 100.w,
                              child:  ListView.builder(
                                  scrollDirection:Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: images?.length,
                                  itemBuilder: (c,i){
                                    return SizedBox(
                                      width: 90.w,
                                      height: 90.w,
                                      child: Image(
                                        image: NetworkImage(images![i]),
                                        width: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                              ),
                            )


                          ],
                        ),
                      ),
                    ),

                    //分割线
                    Container(
                      color: const Color(0xEEEEEEEE),
                      //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      height: 1.h,
                    ),
                    ///显示热度，点赞数和评论数
                    SizedBox(
                      height: 45.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          item(Remix.fire_line, hot.toString()),
                          item(Remix.thumb_up_line, favorite.toString()),
                          item(Icons.comment_outlined, commentNum.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
        )
    );

  }


  Widget item(IconData icon, String count){

    return SizedBox(
       height: 25.w,
       width: 50.w,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Icon(icon,size: 16.w, color: Colors.grey),
           Text(count,style: TextStyle(fontSize: 10.sp,color: Colors.grey),)
         ],
       ),
    );

  }



}