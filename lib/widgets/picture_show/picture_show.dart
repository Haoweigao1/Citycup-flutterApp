
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';


class PictureShow extends StatelessWidget {
  final List<String> picList;

  const PictureShow({super.key, required this.picList});

  @override
  Widget build(BuildContext context) {

    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      primary: false,
      children: List.generate(
        picList.length,
            (index) => GestureDetector(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Image.network(
                picList[index],
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.w,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              NinePicture(picList, index),
            );
          },
        ),
      ),
    );
  }
}

class NinePicture<T> extends PopupRoute<T> {

  final List<String> picList;
  final int index;

  NinePicture(this.picList, this.index);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);


  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GestureDetector(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) => GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: _PictureWidget(picList, index),
          ),
        ),
      ),
    );
  }

  @override
  String? get barrierLabel => null;

}

class _PictureWidget extends StatefulWidget {
  final List picList;
  final int index;

  const _PictureWidget(this.picList, this.index);

  @override
  State createState() {
    return _PictureWidgetState();
  }
}

class _PictureWidgetState extends State<_PictureWidget> {
  int startX = 0;
  int endX = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Center(
                child: Image.network(
                  widget.picList[index],
                  fit: BoxFit.cover,
                ),
              ),
              onHorizontalDragDown: (detail) {
                startX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragUpdate: (detail) {
                endX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragEnd: (detail) {
                _getIndex(endX - startX);
                setState(() {});
              },
              onHorizontalDragCancel: () {},
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.picList.length,
                      (i) => GestureDetector(
                    child: CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      radius: 8.0,
                      backgroundColor: index == i
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        startX = endX = 0;
                        index = i;
                      });
                    },
                  ),
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getIndex(int delta) {
    if (delta > 50) {
      setState(() {
        index--;
        index = index.clamp(0, widget.picList.length - 1);
      });
    } else if (delta < 50) {
      setState(() {
        index++;
        index = index.clamp(0, widget.picList.length - 1);
      });
    }
  }
}
