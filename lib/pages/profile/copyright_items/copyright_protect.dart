import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/constant/constant.dart';
import '../../../theme/app_theme.dart';


class CopyrightProtectPage extends StatelessWidget{

  const CopyrightProtectPage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("维权通道"),
        centerTitle: true,
        backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),
      body: const SafeArea(child: CopyrightProtectBody())
    );
  }

}


class CopyrightProtectBody extends StatefulWidget{

  const CopyrightProtectBody({super.key});

  @override
  State<StatefulWidget> createState() => _CopyRightProtectState();

}

class _CopyRightProtectState extends State<CopyrightProtectBody>{

  @override
  Widget build(BuildContext context) {
     return Padding(
         padding: EdgeInsets.all(20.w),
         child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.w))
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text("如需法律帮助,可加中南大学法学院优秀学生桑先生的微信😋" ,style: TextStyle(fontSize: 14.sp),),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Image(
                    image: const AssetImage("${Constant.IMAGE_PATH}business_card.jpg"),
                    width: 300.w,
                  )
                ],
              ),
            ),

         )
     );

  }


}