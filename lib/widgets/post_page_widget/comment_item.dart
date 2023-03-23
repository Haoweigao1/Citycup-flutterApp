
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/service/post_service.dart';
import 'package:meta_transaction/util/common_dialog.dart';
import 'package:meta_transaction/util/time_util.dart';
import 'package:provider/provider.dart';

import '../../entity/comment_entity.dart';
import '../../entity/reply_entity.dart';
import '../../model/user_info.dart';
import '../../theme/app_theme.dart';
import '../../util/common_toast.dart';


///帖子评论的item
class CommentItem extends StatefulWidget{

  final CommentEntity  comment;
  final String postCreatorId; //帖子发布者id，用于标注评论或回复是不是作者本人
  final Function onRefresh;

  const CommentItem({super.key, required this.comment, required this.postCreatorId, required this.onRefresh});

  @override
  State<StatefulWidget> createState() => _CommentItemState();
}


class _CommentItemState extends State<CommentItem>{


  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    UserInfo userInfo = Provider.of<UserInfo>(context,listen:false);
    debugPrint(userInfo.uid);
    debugPrint(widget.postCreatorId);
    return Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20.w)),
         color: Colors.white,
       ),
       width: double.infinity,
       child: Padding(
         padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 10.w),
         child: Column(
           children: [
             ///评论的本体
             Column(
               children: [
                 ///用户头像，昵称，回复按钮和点赞按钮
                 Row(
                   children: [
                     //头像
                     ClipOval(
                       child: Image(
                         image: getAvatar(widget.comment.avatar ?? ""),
                         width: 40.w,
                         height: 40.w,
                         fit: BoxFit.cover,
                       )
                     ),
                     SizedBox(width: 3.w,),
                     Text(widget.comment.nickname ?? "", style: TextStyle(fontSize: 10.sp,color: Colors.cyan), ),
                     SizedBox(width: 3.w,),
                     widget.comment.uid == widget.postCreatorId? authorFlag(): Container(),
                     const Spacer(),
                     widget.comment.uid == userInfo.uid? GestureDetector(
                       onTap: (){
                         ///删除该评论
                         showCommonDialog(context, "提示", "您确定要删除吗?", () async {
                           bool res = await PostService.delComment(widget.comment.cid);
                           if(res){
                             widget.onRefresh();
                             CommonToast.showToast("删除成功!");
                           }
                         });
                       },
                       child: outlineText("删除")
                     ):Container(),
                     SizedBox(width: 5.w,),
                     GestureDetector(
                       onTap: (){
                         ///回复该评论
                         showCommentDialog(context, widget.comment.nickname ?? "", (val) async {
                            bool res = await PostService.doReply(widget.comment.cid, val);
                            if(res){
                              widget.onRefresh();
                              CommonToast.showToast("评论成功!");
                            }

                         });
                       },
                       child: outlineText("回复")
                     ),
                     SizedBox(width: 10.w,),
                     Icon(Icons.thumb_up_alt_rounded, size: 16.w,),

                   ],
                 ),
                 ///评论的主体内容
                 Container(
                   width: double.infinity,
                   margin: EdgeInsets.only(left: 35.w),
                   child: Text(widget.comment.content, style: TextStyle(fontSize: 13.sp, ))
                 ),
                 SizedBox(
                   height: 3.h,
                 ),
                 Container(
                   width: double.infinity,
                   margin: EdgeInsets.only(left: 35.w),
                   child: Text(getDateScope(checkDate: widget.comment.time.toString()),
                     style: TextStyle(fontSize: 10.sp, color: Colors.grey),),
                 )


               ],

             ),
             ///评论的回复列表
             SizedBox( height: 4.h,),
             widget.comment.replyList.isEmpty? Container():
             Container(
                width: double.infinity,
                margin:  EdgeInsets.only(left: 40.w),

                decoration: BoxDecoration(
                  color: const Color(0xEEEEEEEE),
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
                child: Padding(
                   padding: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 10.w, right: 10.w),
                   child: ListView.builder(
                       itemCount: widget.comment.replyList.length,
                       shrinkWrap: true,
                       itemBuilder: (context, index){
                         return ReplyItem(reply: widget.comment.replyList[index],
                           postCreatorId: widget.postCreatorId, onRefresh: widget.onRefresh,);
                       }),
                )

              )

           ],
         ),
       ),
    );
  }


}

///评论的回复的item
class ReplyItem extends StatefulWidget{

  final ReplyEntity reply;
  final String postCreatorId;
  final Function onRefresh;

  const ReplyItem({super.key, required this.reply, required this.postCreatorId, required this.onRefresh});

  @override
  State<StatefulWidget> createState() => _ReplyItemState();

}

class _ReplyItemState extends State<ReplyItem>{

  @override
  Widget build(BuildContext context) {

    UserInfo userInfo = Provider.of<UserInfo>(context,listen:false);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ///展示用户头像， 昵称和点赞按钮
          Row(
            children: [
              //头像
              ClipOval(
                  child: Image(
                    image: getAvatar(widget.reply.avatar ?? ""),
                    width: 35.w,
                    height: 35.w,
                    fit: BoxFit.cover,
                  )
              ),
              SizedBox(width: 3.w,),
              Text(widget.reply.nickname, style: TextStyle(fontSize: 10.sp,color: Colors.cyan), ),
              SizedBox(width: 3.w,),
              widget.reply.uid == widget.postCreatorId? authorFlag(): Container(),
              SizedBox(width: 3.w,),
              Text(getDateScope(checkDate: widget.reply.time.toString()), style: TextStyle(fontSize: 10.sp, color: Colors.grey),),
              const Spacer(),
              widget.reply.uid == userInfo.uid ? GestureDetector(
                onTap: (){
                  ///删除该回复
                  showCommonDialog(context, "提示", "您确定要删除吗?", () async {
                    bool res = await PostService.delReply(widget.reply.rid);
                    if(res){
                      widget.onRefresh();
                      CommonToast.showToast("删除成功!");
                    }
                  });

                },
                child: outlineText("删除")
                //Text("删除", style: TextStyle(fontSize: 10.sp, color: Colors.redAccent),),
              ):Container(),
              SizedBox(width: 8.w,),
              Icon(Icons.thumb_up_alt_rounded, size: 16.w,),

            ],
          ),
          //SizedBox( height: 5.h,),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 35.w),
              child: Text(widget.reply.content, style: TextStyle(fontSize: 12.sp, ))
          ),

        ],

      ),

    );
  }

}


ImageProvider getAvatar(String url){
  if(url == ""){
    return const AssetImage('assets/images/icon.jpeg');
  }else{
    return NetworkImage(url);
  }

}

///作者标识
Widget authorFlag(){
  return Container(
     width: 30.w,
     height: 12.w,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(5.w)),
       border: Border.all(width: 1, color: Colors.indigo),
     ),
     child: Center(
       child: Text("作者", style: TextStyle(fontSize: 8.sp, color: Colors.indigo),),
     ),
  );

}

Widget outlineText(String text){
  return Container(
    width: 35.w,
    height: 15.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.w)),
      border: Border.all(width: 1, color: Colors.redAccent),
    ),
    child: Center(
      child: Text(text, style: TextStyle(fontSize: 9.sp, color: Colors.redAccent),),
    ),
  );
}


void showCommentDialog(BuildContext context, String name, Function callback) async{
  TextEditingController controller = TextEditingController();

  await showDialog<bool>(context: context, builder: (context){
    return AlertDialog(
      title: const Text("回复评论"),
      titlePadding: EdgeInsets.all(10.w),
      //标题文本样式
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 16.sp ),
      //中间显示的内容
      content:  SizedBox(
        width: 200.w,
        child: BrnInputText(
          maxHeight: 120.w,
          minHeight: 120.w,
          minLines: 1,
          autoFocus: true,
          maxLength: 200,
          borderRadius: 20.w,
          textEditingController: controller,
          textInputAction: TextInputAction.newline,
          bgColor: const Color(0xEEEEEEEE),
          maxHintLines: 20,
          hint: '回复 @$name, 文明发言, 共创美好社区',
          padding: EdgeInsets.all(10.w),
          onTextChange: (text) {

          },
          onSubmit: (text) {

          },
        ),
      ),

      contentPadding: EdgeInsets.all(10.w),
      //中间显示内容的文本样式
      contentTextStyle: TextStyle(color: Colors.black54, fontSize: 14.sp),
      //底部按钮区域
      actions: <Widget>[

        TextButton(
          child: const Text("取消"),
          onPressed: () {
            //关闭 返回true
            Navigator.of(context).pop(true);
          },
        ),

        TextButton(
          child: const Text("确定"),
          onPressed: () {
            if(controller.text == ""){
              CommonToast.showToast("回复内容不能为空");
              return;
            }
            callback(controller.text);
            Navigator.of(context).pop(true);
          },
        ),

      ],
    );

  });

}
