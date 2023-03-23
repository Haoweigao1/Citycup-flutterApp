
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/pages/community/post_detail_page.dart';
import 'package:meta_transaction/widgets/emptity_view/empty_view.dart';
import '../../entity/post_entity.dart';
import '../../service/post_service.dart';
import '../../theme/app_theme.dart';
import '../../util/common_toast.dart';
import '../../util/time_util.dart';
import '../../widgets/post_page_widget/post_card.dart';


class TopicPage extends StatelessWidget{
  final String topic;

  const TopicPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    //屏幕大小自适应
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Scaffold(
       appBar: AppBar(
         title: Text(topic),
         centerTitle: true,
         backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
             : Theme.of(context).primaryColor,
       ),
       body: SafeArea(child: TopicBody(topic: topic,),),
     );
  }

}

class TopicBody extends StatefulWidget{

  final String topic;
  const TopicBody({super.key, required this.topic});


  @override
  State<StatefulWidget> createState() => _TopicBodyState();


}

class _TopicBodyState extends State<TopicBody>{

  int _curPageNum = 1;
  bool _hasData = true;
  final List<PostEntity> _list = [];

  // 滚动控制器final
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getData();
    // 监听滚动事件
    _scrollController.addListener((){
      if(_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 40){
        _getData();
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return _list.isEmpty? const EmptyView(height: double.infinity):
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.w, bottom: 10.w),
        child: ListView.builder(
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
        )
    );
  }



  Future<bool> _getData() async{
    if(_hasData){
      List<PostEntity> list = await PostService.getTopicList(widget.topic, _curPageNum);
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
    bool res = await _getData();
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


