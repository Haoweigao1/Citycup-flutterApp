import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_transaction/constant/constant.dart';
import '../../../theme/app_theme.dart';
import 'dart:io';
import '../../../widgets/animation/press_animation.dart';


class CopyrightRegisterPage extends StatelessWidget{

  const CopyrightRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
     return Scaffold(
       appBar: AppBar(
         title: const Text("版权登记"),
         centerTitle: true,
         backgroundColor: isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
             : Theme.of(context).primaryColor,
       ),
       body: const SafeArea(child: CopyrightRegisterBody()),
     );

  }

}

class CopyrightRegisterBody extends StatefulWidget {

  const CopyrightRegisterBody({super.key});

  @override
  State<StatefulWidget> createState() => _CopyrightRegisterState();

}

class _CopyrightRegisterState extends State<CopyrightRegisterBody>{

  late TextEditingController nameController;
  XFile? mSelectedImageFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
     Color themeColor = isDarkMode(context) ? Theme.of(context).primaryColor.withAlpha(155)
         : Theme.of(context).primaryColor;
     return SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.only(left: 10.w, right: 10.w,top: 5.w,bottom: 20.w),
         child: Column(
           children: [
             ///横幅
             const SizedBox(
               width: double.infinity,
               child: Image(
                 image: AssetImage("${Constant.IMAGE_PATH}copyright_register_banner.jpg"),
                 fit: BoxFit.fill,
               ),
             ),
             Container(
               width: double.infinity,
               clipBehavior: Clip.hardEdge,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
               ),
               child: BrnTextInputFormItem(
                 title: "单位名称/姓名",
                 hint: "单位/个人名称",
                 controller: nameController,
               ),
             ),
             SizedBox(height: 1.h,),
             Container(
               width: double.infinity,
               clipBehavior: Clip.hardEdge,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
               ),
               child: BrnTextInputFormItem(
                 title: "作品名称",
                 hint: "输入作品名称",
                 controller: nameController,
               ),
             ),
             SizedBox(height: 1.h,),
             Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(20.w)),
                   color: Colors.white,),
                 child: Padding(
                   padding: EdgeInsets.only(left: 20.w),
                   child:  Row(
                     children: [
                       const Center(
                         child: Text("作品描述", style: TextStyle(fontSize: 16,)),
                       ),
                       const Spacer(),
                       SizedBox(
                         width: 220.w,
                         child: BrnInputText(
                           borderRadius: 20.w,
                           maxHeight: 120.w,
                           minHeight: 80.w,
                           minLines: 1,
                           maxLength: 500,
                           bgColor: Colors.grey[200]!,
                           //textEditingController: _descriptionController,
                           textInputAction: TextInputAction.newline,
                           maxHintLines: 20,
                           hint: "输入作品描述~",
                           autoFocus: false,
                           padding: EdgeInsets.all(10.w),
                           onTextChange: (text) {},
                           onSubmit: (text) {},
                         ),
                       ),
                     ],
                   )
                 ),
               ),
             SizedBox(height: 1.h,),
             Container(
               height: 50,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
                 color: Colors.white,),
               child: Padding(
                   padding: const EdgeInsets.only(left: 20,right: 20),
                   child:  Row(
                     children: [
                       const Center(
                         child: Text("创作完成日期", style: TextStyle(fontSize: 16,)),
                       ),
                       const Spacer(),
                       GestureDetector(
                         onTap: (){ _showDatePickerForDay(context); },
                         child: const Text("请选择 >", style: TextStyle(fontSize: 16, color: Colors.grey),),
                       )
                     ],
                   )
               ),
             ),
             SizedBox(height: 1.h,),
             Container(
               width: double.infinity,
               clipBehavior: Clip.hardEdge,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
               ),
               child: BrnTextInputFormItem(
                 title: "权利归属方式",
                 hint: "请选择",
                 controller: nameController,
               ),
             ),

             SizedBox(height: 1.h,),
             Container(
               width: double.infinity,
               clipBehavior: Clip.hardEdge,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
               ),
               child: BrnTextInputFormItem(
                 title: "联系人",
                 hint: "输入联系人",
                 controller: nameController,
               ),
             ),
             SizedBox(height: 1.h,),

             Container(
               width: double.infinity,
               clipBehavior: Clip.hardEdge,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
               ),
               child: BrnTextInputFormItem(
                 title: "手机号",
                 hint: "请输入手机号",
                 controller: nameController,
               ),
             ),
             SizedBox(height: 1.h,),
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
                       child: Text("上传作品", style: TextStyle(fontSize: 16),),
                     ),
                     Spacer(),
                   ],
                 )
               ),
             ),
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
                     onTap: () {
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
                           File(mSelectedImageFile?.path??"")  ,
                           width: double.infinity,
                           height: double.infinity,
                           fit: BoxFit.cover,
                         ),
                       ),
                       Align(
                         alignment: Alignment.topRight,
                         child: InkWell(
                           onTap: () {
                             mSelectedImageFile = null;
                             setState(() {});
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
             ///上传按钮
             AnimatedPress(
                 child: OutlinedButton(
                   style: ButtonStyle(
                       side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                       minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                       shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                   ),
                   onPressed: () {

                   },
                   child: Text("上传",
                       style: TextStyle(color: themeColor,
                           fontSize: 15.sp,fontWeight: FontWeight.w300)),
                 )
             ),

           ],
         ),
       ),
     );
  }


}



Future<DateTime?> _showDatePickerForDay(BuildContext context) {
  return showDatePicker(
    context: context, // 上下文
    initialDate: DateTime.now(), // 初始化选中日期
    firstDate: DateTime(2000, 1), // 开始日期
    lastDate: DateTime.now(), // 结束日期
    currentDate: DateTime.now(), // 当前日期
    initialEntryMode: DatePickerEntryMode
        .calendar, // 日历弹框样式 calendar: 默认显示日历，可切换成输入模式，input:默认显示输入模式，可切换到日历，calendarOnly:只显示日历，inputOnly:只显示输入模式
    selectableDayPredicate: (dayTime) {
      return true;
    },
    helpText: "请选择日期", // 左上角提示文字
    cancelText: "取消", // 取消按钮 文案
    confirmText: "确定", // 确认按钮 文案
    initialDatePickerMode: DatePickerMode.day, // 日期选择模式 默认为天
    useRootNavigator: true, // 是否使用根导航器
    errorFormatText: "输入日期格式有误，请重新输入", // 输入日期 格式错误提示
    errorInvalidText: "输入日期不合法，请重新输入", // 输入日期 不在first 与 last 之间提示
    fieldLabelText: "输入所选日期", // 输入框上方 提示
    fieldHintText: "请输入日期", // 输入框为空时提示
    textDirection: TextDirection.ltr, // 水平方向 显示方向 默认 ltr
  );
}



