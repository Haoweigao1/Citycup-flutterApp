import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_transaction/util/common_toast.dart';
import '../../../theme/app_theme.dart';
import '../../../util/common_util.dart';
import '../../../widgets/animation/press_animation.dart';
import 'dart:io';


class CopyrightDetectPage extends StatelessWidget{

  const CopyrightDetectPage({super.key});

  @override
  Widget build(BuildContext context) {

    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("版权检测"),
        centerTitle: true,
        backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),
      body: const SafeArea(child: CopyrightDetect()),
    );
  }

}


class CopyrightDetect extends StatefulWidget{

  const CopyrightDetect({super.key});


  @override
  State<StatefulWidget> createState() => _CopyrightDetectState();

}

class _CopyrightDetectState extends State<CopyrightDetect>{

  late TextEditingController _nameController;
  late TextEditingController _idNumberController;
  late TextEditingController _phoneController;

  XFile? mSelectedImageFile;

  @override
  void initState() {
    _nameController = TextEditingController();
    _idNumberController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;
     return SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.all(10.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.w,left: 10.w, right: 10.w),
              child: Column(
                children: [
                  ///展示版权检测须知
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.w),
                      child:  Column(
                        children: [
                          Text("版权检测须知", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
                          SizedBox(height: 3.h,),
                          Text("     哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", style: TextStyle(fontSize: 13.sp),)
                        ],
                      )
                    )

                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  ///填写个人信息
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: BrnTextInputFormItem(
                      title: "姓名",
                      hint: "输入真实姓名",
                      controller: _nameController,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: BrnTextInputFormItem(
                      title: "身份证号",
                      hint: "输入身份证号",
                      controller: _idNumberController,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: BrnTextInputFormItem(
                      title: "电话",
                      hint: "输入电话号码",
                      controller: _phoneController,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: const [
                            Center(
                              child: Text("上传截图证据", style: TextStyle(fontSize: 16),),
                            ),
                            Spacer(),
                          ],
                        )
                    ),
                  ),
                  ///上传截图证据
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisCount: 2,
                    children: List.generate(1, (index) {
                      /// 这个方法体用于生成GridView中的一个item
                      Widget content;
                      if (mSelectedImageFile == null) {
                        /// 添加图片按钮
                        var addCell = Center(
                            child: Image.asset(
                              'assets/images/mine_feedback_add_image.png',
                              width: double.infinity,
                              height: double.infinity,
                            ));
                        content = GestureDetector(
                          onTap: (){
                            final ImagePicker picker = ImagePicker();
                            final Future<XFile?> image =  picker.pickImage(source: ImageSource.gallery);
                            image.then((result) {
                              setState(() {
                                if(result != null) {
                                  mSelectedImageFile = result;
                                }
                              });
                            });
                          },
                          child: addCell,
                        );
                      } else {
                        /// 被选中的图片
                        content = Stack(
                          children: <Widget>[
                            Center(
                              child: Image.file(
                                File(mSelectedImageFile?.path??""),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    mSelectedImageFile = null;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/mine_feedback_ic_del.png',
                                  width: 20.0,
                                  height: 20.0,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return Container(
                        margin: EdgeInsets.all(2.w),
                        width: 120.w,
                        height: 120.w,
                        color: const Color(0xFFffffff),
                        child: content,
                      );

                    }),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  AnimatedPress(
                      child: OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                            minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:
                                        BorderRadius.circular(20.w)))
                        ),
                        onPressed: () {
                            ///先检查一遍是不是所有内容都填了
                            if(_nameController.text == ""){
                              CommonToast.showToast("请填写姓名!");
                              return;
                            }
                            if(_idNumberController.text == ""){
                              CommonToast.showToast("请填写身份证号!");
                              return;
                            }
                            if(_phoneController.text == ""){
                              CommonToast.showToast("请填写电话!");
                              return;
                            }
                            if(!isCardId(_idNumberController.text)){
                              CommonToast.showToast("请正确填写身份证号!");
                              return;
                            }


                        },
                        child: Text("上传",
                            style: TextStyle(color: themeColor,
                                fontSize: 15.sp,fontWeight: FontWeight.w300)),
                        )
                  ),


                ],
              ),
            ),
          ),
        )


     );





  }

}