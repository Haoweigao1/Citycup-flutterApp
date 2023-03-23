
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/news_page_widget/news_card.dart';
import '../../entity/news_entity.dart';
import '../../service/news_service.dart';
import '../../theme/app_theme.dart';
import '../../util/common_toast.dart';



class NewsListPage extends StatelessWidget{

  final String title;
  final int type;

  
  const NewsListPage({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    //屏幕大小自适应
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return  Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: isDarkMode(context)
            ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),

      body: NewsList(type: type),
    );
  }




}



class NewsList extends StatefulWidget{

  final int type;

  const NewsList({super.key, required this.type});

  @override
  State<StatefulWidget> createState() => _NewsListState();

}


class _NewsListState extends State<NewsList>{

  int _curPageNum = 1;
  bool _hasData = true;
  final List<NewsEntity> _newsList = [];

  final ScrollController _scrollController = ScrollController();

  Future<void> _onRefresh() async {
    setState(() {
      _curPageNum = 1;
      _newsList.clear();
      _hasData = true;
    });
    bool res = await _getData();
    if(res){
      CommonToast.showToast("刷新成功!");
    }
  }

  Future<bool> _getData() async {
    if(_hasData){
      List<NewsEntity>? list = await NewsService.getNewsList(widget.type, _curPageNum);
      setState(() {
        // 拼接数据
        _newsList.addAll(list);
        _curPageNum ++;
        debugPrint(_curPageNum.toString());
        debugPrint(_newsList.length.toString());
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
     return RefreshIndicator(
         onRefresh: () => _onRefresh(),
         child: ListView.builder(
           primary: false,
           shrinkWrap: true,
           itemCount: _newsList.length,
           controller: _scrollController,
           itemBuilder: (context, index) {
               Widget tip = Container();
               // 当渲染到最后一条数据时，加载动画提示
               if (index == _newsList.length - 1) {
                 tip = _getMoreWidget();
               }

               return Column(
                 children: <Widget>[
                   SizedBox(height: 5.w,),
                   NewsCard(
                       image: _newsList[index].image,
                       url: _newsList[index].url,
                       summary: _newsList[index].summary,
                       source: _newsList[index].source,
                       time: _newsList[index].time!),
                   SizedBox(height: 5.w,),
                   // 加载提示
                   tip
                 ],


                 );
              }

              ),
     );
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
