

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/widgets/bottom_sheet/my_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../entity/post_entity.dart';
import '../../../model/user_info.dart';
import '../../../service/post_service.dart';
import '../../../theme/app_theme.dart';
import '../../../util/common_dialog.dart';
import '../../../util/common_toast.dart';
import '../../../util/time_util.dart';
import '../../../widgets/emptity_view/empty_view.dart';
import '../../../widgets/post_page_widget/post_card.dart';
import '../../community/post_detail_page.dart';


class PostManagePage extends StatelessWidget{

  const PostManagePage({super.key});



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

     return Scaffold(
        appBar:  AppBar(
          title: const Text("我的话题"),
          centerTitle: true,
          backgroundColor: isDarkMode(context)
              ? Theme.of(context).primaryColor.withAlpha(155)
              : Theme.of(context).primaryColor,
        ),
        body: const SafeArea(child: MyPostList()),
     );

  }


}


class MyPostList extends StatefulWidget{

  const MyPostList({super.key});


  @override
  State<StatefulWidget> createState() => _MyPostListState();


}


class _MyPostListState extends State<MyPostList>{


  final List<PostEntity> _myPostList = [];
  int _curPageNum = 1;
  bool _hasData = true;
  final ScrollController _scrollController = ScrollController();
  final List<String> _options = ["删除" , "查看详情"];

  ///刷新
  Future _onRefresh() async{
    setState(() {
      _curPageNum = 1;
      _myPostList.clear();
      _hasData = true;
    });
    bool res = await _getData();
    if(res){
      CommonToast.showToast("刷新成功!");
    }
  }

  Future<bool> _getData() async{
    if(_hasData){
      List<PostEntity> list = await PostService.getMyPostList(_curPageNum);
      setState(() {
        // 拼接数据
        _myPostList.addAll(list);
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
    UserInfo userInfo = Provider.of<UserInfo>(context,listen: false);


    ///设置可以刷新
      return _myPostList.isEmpty? const EmptyView(height: double.infinity) :
      RefreshIndicator(
          onRefresh: () => _onRefresh(),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.w),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _myPostList.length,
                controller: _scrollController,
                itemBuilder: (context, index){
                  Widget tip = const Text("");
                  // 当渲染到最后一条数据时，加载动画提示
                  if(index == _myPostList.length - 1){
                    tip = _getMoreWidget();
                  }
                  List<String>? images = _myPostList[index].images?.split('|');
                  String? title = _myPostList[index].title?.split('#&')[0];
                  _myPostList[index].creatorAvatar = userInfo.avatar;
                  _myPostList[index].creatorName = userInfo.nickname;
                  debugPrint(_myPostList[index].creatorAvatar);
                  return Column(
                    children: <Widget>[

                      PostCard(
                        time: getDateScope(checkDate: _myPostList[index].time.toString()),
                        title: title,
                        hot: _myPostList[index].hot,
                        favorite: _myPostList[index].favoriteNum,
                        commentNum: _myPostList[index].commentNum,
                        avatar: _myPostList[index].creatorAvatar,
                        nickname: _myPostList[index].creatorName,
                        images: images,
                        onTap: () async {
                          ///删除或跳转到详情页面
                          int? res = await showCustomModalBottomSheet(context, "操作", _options);
                          if(res == 0){
                            ///删除
                              bool m = await PostService.deletePost(_myPostList[index].pid!);
                              if(m){
                                await _getData();
                                CommonToast.showToast("删除成功!");
                              }
                          }else if(res == 1){
                            if(mounted) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailPage(
                                          post: _myPostList[index])));
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10.w,),
                      // 加载提示
                      tip
                    ],

                  );
                }),
          )




      );
  }


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


