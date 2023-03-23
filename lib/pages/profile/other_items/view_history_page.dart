import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/db/sharedPreference_db.dart';
import 'package:meta_transaction/util/common_dialog.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:meta_transaction/widgets/animation/press_animation.dart';
import 'package:meta_transaction/widgets/emptity_view/empty_view.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/news_page_widget/news_history_item.dart';



class ViewHistoryPage extends StatelessWidget{

  final GlobalKey myKey = GlobalKey();
  ViewHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("浏览历史"),
        centerTitle: true,
        backgroundColor: isDarkMode(context)
            ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
        actions: [
          AnimatedPress(
              child:IconButton(
                icon: Icon(Icons.delete_outline, size: 20.w),
                onPressed: (){
                  //删除历史
                  showCommonDialog(context, "提示", "确定清空浏览历史吗?", ()async{
                     await PreferencesDB().delNewsHistory();
                     await (myKey.currentState as HistoryListState).loadData();
                     CommonToast.showToast("删除成功!");
                  });
                },
              )
          ),
        ],
      ),
     body: SafeArea(child: HistoryList(myKey: myKey,)),
    );

  }

}

class HistoryList extends StatefulWidget{

  final Key myKey;
  const HistoryList({
    required this.myKey,
  }):super(key: myKey);

  @override
  State<StatefulWidget> createState() => HistoryListState();

}

class HistoryListState extends State<HistoryList>{

  List<String> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    List<String> res = await PreferencesDB().getNewsHistory();
    setState(
        () {
          data = res;
        }
    );

    debugPrint("调用该方法");
  }

  @override
  Widget build(BuildContext context) {
     return data.isEmpty? const EmptyView(height: double.infinity):
         ListView.builder(
             shrinkWrap: true,
             itemCount: data.length,
             itemBuilder: (context, index){
                List<String> val = data[index].split("|");
                return Column(
                  children: [
                    HistoryItem(
                      summary: val[0],
                      url: val[1],
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                );
             }
         );
  }


}