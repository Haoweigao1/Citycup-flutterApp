import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/service/post_service.dart';
import 'package:meta_transaction/widgets/picture_show/picture_show.dart';
import 'package:remixicon/remixicon.dart';
import '../../entity/post_entity.dart';
import '../../theme/app_theme.dart';
import '../../util/time_util.dart';



///帖子详情卡片 (无评论列表)
class PostDetailCard extends StatefulWidget{

  final PostEntity postEntity;


  const PostDetailCard({
    super.key,
    required this.postEntity,
  });


  @override
  State<StatefulWidget> createState() => _PostDetailCardState();


}


class _PostDetailCardState extends State<PostDetailCard>{

  bool _isFavorite = false;

  void getIsFavorite() async{
     bool res = await PostService.isFavorite(widget.postEntity.pid.toString(), "0");
     setState(() {
       _isFavorite = res;
     });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    List<String>? values = widget.postEntity.title?.split("#&");
    List<String>? images = widget.postEntity.images?.split("|");
    return Container(

        width: double.infinity,  //横向布满整个屏幕
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(35.w)),
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
                      child: widget.postEntity.creatorAvatar == ""? Image(
                          image: const AssetImage('assets/images/icon.jpeg'),
                          width: 45.w, fit: BoxFit.cover, height: 45.w,): Image(
                          image: NetworkImage(widget.postEntity.creatorAvatar!),
                          width: 45.w, fit: BoxFit.cover, height: 45.w,),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(widget.postEntity.creatorName == ""? "无昵称": widget.postEntity.creatorName! ,
                      style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500),),
                    //占位
                    const Spacer(),
                    Text(getDateScope(checkDate: widget.postEntity.time.toString()),
                        style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,
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
                      ///展示标题
                      values == null? const SizedBox(): SizedBox(
                        height: 25.h,
                        child: Center(
                          child: Text(values[0]! ,style: TextStyle(fontSize: 16.sp ),),
                        ),
                      ),
                      ///展示内容
                      SizedBox(
                        width: double.infinity,
                        child: Text(widget.postEntity.content, style: TextStyle(fontSize: 14.sp),),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      ///展示图片九宫格
                      images == null? Container(): PictureShow(picList: images),

                      SizedBox(
                        height: 10.w,
                      ),
                      ///展示话题类型
                      values == null || values.length < 2 ? Container( height: 0.h,):
                      SizedBox(
                        height: 35.w,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: values.length - 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Row(
                                children: [
                                  topicItem(values[index + 1]),
                                  SizedBox(width: 10.w,),
                                ],
                              );
                            }
                        )
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
                      SizedBox(
                        height: 25.w,
                        width: 50.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.local_fire_department_outlined,size: 20.w, color: Colors.grey),
                            Text(widget.postEntity.hot.toString(),style: TextStyle(fontSize: 10.sp,color: Colors.grey),)
                          ],
                        ),
                     ),
                    SizedBox(
                      height: 25.w,
                      width: 50.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.star_border_outlined,size: 20.w, color: Colors.grey),
                          //Text(widget.postEntity.hot.toString(),style: TextStyle(fontSize: 10.sp,color: Colors.grey),)
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        ///进行点赞
                        bool res = await PostService.doFavorite(widget.postEntity.pid.toString());
                        if(res){
                          setState(() {
                            _isFavorite = true;
                          });
                        }
                      },
                      child: SizedBox(
                        height: 25.w,
                        width: 50.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(_isFavorite?Remix.thumb_up_fill: Remix.thumb_up_line,
                                size: 20.w, color: _isFavorite?Colors.redAccent: Colors.grey),
                            //Text(widget.postEntity.favoriteNum.toString(),style: TextStyle(fontSize: 10.sp,color: Colors.grey),)
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        )
    );

  }


  Widget item(IconData icon, String count, Color color){
    return SizedBox(
      height: 25.w,
      width: 50.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon,size: 16.w, color: color),
          Text(count,style: TextStyle(fontSize: 10.sp,color: color),)
        ],
      ),
    );
  }


  Widget topicItem(String topic){
    return Container(
      height: 30.w,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Center(
        child: Text("#$topic", style: TextStyle(fontSize: 12.sp, color: Colors.white), ),
      )
    );
  }


}