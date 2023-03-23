

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';
import 'animation/press_animation.dart';

class ItemCell extends StatefulWidget{
  final IconData iconData;
  final String title;
  final Function onClick;
  final int count;

  const ItemCell({
    super.key,
    required this.iconData,
    required this.title,
    required this.onClick,
    required this.count,
  });





  @override
  State<StatefulWidget> createState() => _ItemCellState();


}


class _ItemCellState extends State<ItemCell>{

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    double cWidth;
    if (widget.count < 10) {
      cWidth = 20;
    } else if (widget.count > 100) {
      cWidth = 35;
    } else {
      cWidth = 30;
    }
    return GestureDetector(
      onTap: (){  widget.onClick(); },
      child: AnimatedPress(
        child:Container(
          color: Colors.white,
          width: 60.w,
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 30.w,
                    margin: EdgeInsets.only(top: 0.w,left: 5.w),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Icon(
                        widget.iconData,
                        size: 22.w,
                        color: const Color(0xFF3479FD),
                      ),
                    )

                  ),
                  Offstage(
                    ///这里隐藏的条件是count=0的时候，Offstage包含的模块（角标）会隐藏，考虑的是下面没有角标的item
                    offstage: widget.count == 0,
                    child: Container(
                      margin: EdgeInsets.only(left: 35.w),
                      width: cWidth,
                      height: 14.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.w),
                            bottomRight: Radius.circular(7.w),
                            topRight: Radius.circular(7.w)),
                        color: const Color(0xFFFF491C),
                      ),
                      child: Text(
                        widget.count >= 100 ? '99+' : widget.count.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: 58.w,
                margin: EdgeInsets.only(top: 35.w),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}