import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// 按钮可点击时的样式
final TextStyle _availableStyle =
TextStyle(fontSize: 14.sp, color: const Color(0xFFFFFFFF));
// 按钮禁用时的样式
final TextStyle _unavailableStyle =
TextStyle(fontSize: 14.sp, color: const Color(0x99999999));
// 按钮可点击时背景的样式
final BoxDecoration _availableBox = BoxDecoration(
  color: Colors.teal,
  borderRadius: BorderRadius.all(Radius.circular(25.w)),
);
// 按钮不可点击时背景的样式
final BoxDecoration _unavailableBox = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.black, width: 2.w),
  borderRadius: BorderRadius.all(Radius.circular(25.w)),
);

class CountdownButton extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  /// 用户点击时的回调函数。
  final Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  bool available;

  CountdownButton({super.key,
    this.countdown  = 60,
    required this.onTapCallback,
    this.available = true,
  });

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  /// 倒计时的计时器。
  late Timer _timer;

  /// 当前倒计时的秒数。
  late int _seconds;
  // 初始化文本
  late String _verifyStr;

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
    _verifyStr = '${widget.countdown}s后重发';
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    setState(() {
      widget.available = false;
    });
    widget.onTapCallback();
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 1) {
        _cancelTimer();
        _seconds = widget.countdown;
        _verifyStr = '${widget.countdown}s后重发';
        setState(() {
          widget.available = true;
        });
        return;
      }
      _seconds--;
      _verifyStr = '${_seconds}s后重发';
      setState(() {});
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.available
        ? GestureDetector(
      onTap: _startTimer,
      child: Container(
        width: 100.w,
        height: 40.w,
        margin: EdgeInsets.only(left: 20.w),
        decoration: _availableBox,
        child: Center(
          child: Text(
            '获取验证码',
            style: TextStyle(
                fontSize: 14.sp,
               ),
            ),
          ),
       ),
    ) : GestureDetector(
        onTap: _seconds == widget.countdown ? _startTimer : null,
        child: Container(
          width: 100.w,
          height: 40.w,
          margin: EdgeInsets.only(left: 20.w),
          decoration: _unavailableBox,
          child: Center(
            child: Text(
              _verifyStr,
              style: _unavailableStyle,
            ),
          ),
        ));
  }
}

