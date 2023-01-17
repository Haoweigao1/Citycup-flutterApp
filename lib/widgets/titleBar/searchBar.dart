import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

class SearchBar extends StatefulWidget {
  final String title;  //标题文字，为空串则不显示
  final String hintVal;
  final void Function()? goBackCallback; //返回
  final String? inputValue;
  final String? defaultInputValue;
  final Function()? navigate;   //有此函数表明搜索栏仅为装饰物，用于跳转至搜索页面
  final Function(String val)? submitCallback;

  const SearchBar(
      {Key? key,
        required this.title,
        required this.hintVal,
        this.goBackCallback,
        this.inputValue,
        this.defaultInputValue,
        this.navigate,
        this.submitCallback,
        })
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchWord = '';

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.inputValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    final iconSize = 20.sp;

    return Row(
      children: [
        if(widget.title != "")
          Text(widget.title),
        SizedBox(width:20.sp),
        Expanded(
          child: Container(
            height: 30.sp,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18.sp)),
            padding: EdgeInsets.only(left: 8.sp),
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: _controller,
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: -4.sp),
                hintText: widget.hintVal,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  size: iconSize,
                  color: Colors.grey,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _controller.clear();
                    setState(() {
                      _searchWord = '';
                    });
                  },
                  child: Icon(
                    Icons.clear,
                    size: iconSize,
                    color: Colors.grey,
                  ),
                ),
              ),
              onEditingComplete: widget.submitCallback != null? widget.submitCallback!(_controller.text): null,
              onTap: widget.navigate,
              readOnly:  widget.navigate == null? false: true,
              autofocus: widget.navigate == null ? true: false,
            ),
          ),
        ),
        SizedBox(width: 10.sp),
        if (widget.goBackCallback != null)
          GestureDetector(
            onTap: widget.goBackCallback,
            child: Text(
              '取消',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }
}
