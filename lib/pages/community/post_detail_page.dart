import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/entity/comment_entity.dart';
import 'package:meta_transaction/service/post_service.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/widgets/post_page_widget/comment_item.dart';
import 'package:meta_transaction/widgets/post_page_widget/post_detail_card.dart';
import '../../constant/constant.dart';
import '../../entity/post_entity.dart';
import '../../theme/app_theme.dart';
import '../../widgets/emptity_view/empty_view.dart';


///展示帖子的详情内容，评论等

class PostDetailPage extends StatelessWidget{
  final PostEntity post;

  const PostDetailPage({super.key, required this.post});


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Scaffold(
       appBar: AppBar(
         title: const Text("详情"),
         centerTitle: true,
         backgroundColor: isDarkMode(context)
             ? Theme.of(context).primaryColor.withAlpha(155)
             : Theme.of(context).primaryColor,
       ),
       body: SafeArea(child: PostDetailBody(data: post,))
     );
  }


}

class PostDetailBody extends StatefulWidget{
  final PostEntity data;

  const PostDetailBody({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _PostDetailBodyState();

}

class _PostDetailBodyState extends State<PostDetailBody>{

  List<CommentEntity> commentList = [];

   ///刷新评论列表
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds:1500),() async {
      List<CommentEntity> list = await PostService.getCommentList(
          widget.data.pid!);
      setState(() {
        commentList = list;
      });
    });
  }

  Future<void> _getData() async {
    List<CommentEntity> list =  await PostService.getCommentList(widget.data.pid!);
    //debugPrint("这个有数据：" + list.length.toString() + "  " + widget.data.pid!);
    setState(() {
      commentList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child:  CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 48.h,top: 10.w),
                      child: Column(
                        children: [
                          ///帖子主体
                          PostDetailCard(postEntity: widget.data),
                          SizedBox(height: 20.h,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20.w))
                            ),
                            width: double.infinity,
                            height: 40.h,
                            child: Padding(
                              padding: EdgeInsets.only(left:20.w, right: 20.w, top: 10.w, bottom: 10.w),
                              child: Row(
                                children: [
                                  Text("评论留言", style: TextStyle(fontSize: 14.sp, ),),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      ///触发评论效果
                                      showCommentDialog(context, widget.data.creatorName??"", (val) async {
                                        //debugPrint("评论内容:"+res);

                                        bool  res = await PostService.doComment(widget.data.pid!, val);
                                        if(res){
                                           CommonToast.showToast("评论成功!");
                                         }
                                      });
                                    },
                                    child: Text("我要评论 >", style: TextStyle(fontSize: 12.sp, color: Colors.redAccent),),
                                  )
                                ],
                              ),
                            )
                          ),

                          SizedBox(height: 1.h,),
                          ///帖子列表
                          commentList.isEmpty? EmptyView(height: 220.h,): ListView.builder(
                              shrinkWrap: true,
                              itemCount: commentList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                   return Column(
                                     children: [
                                       CommentItem(comment: commentList[index],
                                         postCreatorId: widget.data.creatorId,onRefresh: () => _getData(),),
                                       SizedBox(height: 1.h,)
                                     ],

                                   );


                                }
                              ),



                        ],

                      ),



                      );
                  },
                  childCount: 1
              ),
            )
          ],
        ),
      );
  }




}



void showCommentDialog(BuildContext context, String name, Function callback) async{
    TextEditingController controller = TextEditingController();

    bool? isSelect  = await showDialog<bool>(context: context, builder: (context){
      return AlertDialog(
        title: const Text("评论话题"),
        //title 的内边距，默认 left: 24.0,top: 24.0, right 24.0
        //默认底部边距 如果 content 不为null 则底部内边距为0
        //            如果 content 为 null 则底部内边距为20
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
                CommonToast.showToast("评论内容不能为空");
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

