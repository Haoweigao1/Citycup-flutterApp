
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/pages/community/post_detail_page.dart';
import 'package:meta_transaction/service/post_service.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/widgets/post_page_widget/post_card.dart';
import '../../entity/post_entity.dart';
import '../../theme/app_theme.dart';
import '../../util/time_util.dart';



///根据数据渲染出帖子列表
class PostList extends StatefulWidget{

  final String type;
  final Key myKey;

  const PostList({
    required this.myKey,
    required this.type
  }):super(key: myKey);


  @override
  State<StatefulWidget> createState() => PostListState();
}

class PostListState extends State<PostList>{

  int _curPageNum = 1;
  bool _hasData = true;
  final List<PostEntity> _list = [];

  // 滚动控制器final
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {

    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //屏幕大小自适应
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return ListView.builder(
         // 上拉加载控制器
          controller: _scrollController,
          itemCount: _list.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            Widget tip = const Text("");
            // 当渲染到最后一条数据时，加载动画提示
            if(index == _list.length - 1){
              tip = _getMoreWidget();

            }
            List<String>? images = _list[index].images?.split('|');
            String? title = _list[index].title?.split('#&')[0];
            return Column(
                  children: <Widget>[
                    
                    PostCard(
                      time: getDateScope(checkDate: _list[index].time.toString()),
                      title: title,
                      hot: _list[index].hot,
                      favorite: _list[index].favoriteNum,
                      commentNum: _list[index].commentNum,
                      avatar: _list[index].creatorAvatar,
                      nickname: _list[index].creatorName,
                      images: images,
                      onTap: (){
                        ///增加热度
                        PostService.addHot(_list[index].pid.toString());
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PostDetailPage(post: _list[index])));
                        },
                    ),
                    SizedBox(height: 10.w,),
                    // 加载提示
                    tip
                  ],

            );
          },
      );

  }

  Future<bool> getData() async{
    if(_hasData){
      List<PostEntity> list = await PostService.getPostList(_curPageNum, widget.type);
      setState(() {
        // 拼接数据
        _list.addAll(list);
        _curPageNum ++;
      });
      if(list.length < 10){
        setState(() {
          // 关闭加载
          _hasData = false;
        });
        return true;
      }
    }
    return false;
  }

  /// 下拉刷新
  Future<void> onRefresh() async{
      setState(() {
        _curPageNum = 1;
        _list.clear();
        _hasData = true;
       });
       bool res = await getData();
       if(res){
         CommonToast.showToast("刷新成功!");
       }
  }



  /// 加载动画
  Widget _getMoreWidget() {
    // 如果还有数据
    if(_hasData){
      return Center(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '加载中',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(
                width: 10.w,
              ),
              // 加载图标
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(
                  strokeWidth: 1.w,
                ),
              )
            ],
          ),
        ),
      );
    }else{
      return const Center(
        child: Text("······我是有底线的······"),
      );
    }
  }


}
