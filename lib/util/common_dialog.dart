import 'package:flutter/material.dart';

///普通弹窗
void showCommonDialog(BuildContext context, String title, String content, Function onDefine) async{

  await showDialog<bool>(context: context, builder: (context){
    return AlertDialog(
      title: Text(title),
      titlePadding: const EdgeInsets.all(10),
      //标题文本样式
      titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 16 ),
      //中间显示的内容
      content:  Text(content),

      contentPadding: const EdgeInsets.all(10),
      //中间显示内容的文本样式
      contentTextStyle: const TextStyle(color: Colors.black54, fontSize: 14),
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
            onDefine();
            Navigator.of(context).pop(true);
          },
        ),

      ],
    );

  });



}