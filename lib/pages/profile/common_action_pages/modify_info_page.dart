
import 'dart:io';
import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_transaction/service/user_service.dart';
import 'package:meta_transaction/widgets/bottom_sheet/my_bottom_sheet.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../../../model/user_info.dart';
import '../../../theme/app_theme.dart';
import '../../../util/common_toast.dart';
import '../../../widgets/animation/press_animation.dart';

///修改个人信息页面

class ModifyInfoPage extends StatelessWidget{

  const ModifyInfoPage({super.key});


  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("编辑资料"),
        centerTitle: true,
        backgroundColor: isDarkMode(context)
            ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
      ),
      body: const SafeArea(child: ModifyInfoBody()),
    );
  }


}

class ModifyInfoBody extends StatefulWidget{

  const ModifyInfoBody({super.key});

  @override
  State<StatefulWidget> createState() => _ModifyInfoBodyState();


}


class _ModifyInfoBodyState extends State<ModifyInfoBody>{

  late TextEditingController _descriptionController;
  late TextEditingController _nicknameController;
  late TextEditingController _phoneController;
  String _gender = "";

  final List<String> _genderList = ["男", "女", "神秘"];

  XFile?  selectedAvatar;
  MultipartFile? submitAvatar;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _nicknameController = TextEditingController();
    _phoneController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {

    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

     return Consumer<UserInfo>(
         builder: (_, userInfo, child) {
           _descriptionController.text = userInfo.description;
           _nicknameController.text = userInfo.nickname;
           _phoneController.text = userInfo.phone;

           return  CustomScrollView(
             slivers: [
               SliverList(
                 delegate: SliverChildBuilderDelegate(
                         (context, index) {
                       return Padding(
                         padding: EdgeInsets.only(top: 5.h, bottom: 48.h),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ///修改头像
                             Container(
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
                               ),

                               child: item("头像", GestureDetector(
                                 onTap: (){
                                   ///点击从相册选择头像
                                   final ImagePicker picker = ImagePicker();
                                   final Future<XFile?> image =  picker.pickImage(source: ImageSource.gallery);
                                   image.then((result) {
                                     setState(() {
                                       if(result != null) {
                                         selectedAvatar = result;
                                       }
                                     });
                                   });
                                 },
                                 child: ClipOval(
                                   child: getImage(userInfo.avatar ?? ""),
                                 ),
                               )),
                             ),

                             SizedBox( height: 5.h),

                             Container(
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
                                 color: Colors.white,

                               ),
                               child: Column(
                                 children: [
                                   item("昵称", SizedBox(
                                     width: 220.w,
                                     height: 40.w,
                                     child: TextField(
                                       maxLines: 1,
                                       style: TextStyle(fontSize: 13.sp),
                                       textAlign: TextAlign.end,
                                       decoration: const InputDecoration(
                                         border: InputBorder.none,
                                         hintText: "输入昵称",
                                       ),
                                       controller: _nicknameController,
                                     ),
                                   )),
                                   Container(
                                     color: const  Color(0xEEEEEEEE),
                                     height: 1.h,
                                     width: 300.w,
                                   ),
                                   item("性别", GestureDetector(
                                     onTap: () async {
                                        int? index = await showCustomModalBottomSheet(context, "性别选择", _genderList);
                                        debugPrint(index?.toString());
                                        if(index != null) {
                                          setState((){
                                            _gender = _genderList[index];
                                            debugPrint(_gender);
                                          });
                                        }
                                      },
                                     child: SizedBox(
                                       width: 50.w,
                                       height: 40.w,
                                       child: Center(child: Text(_gender == ""? getDefaultGender(userInfo): _gender,
                                         style: TextStyle(fontSize: 13.sp),),),
                                     ),
                                   )),
                                   Container(
                                     color: const Color(0xEEEEEEEE),
                                     height: 1.h,
                                     width: 300.w,
                                   ),

                                   item("电话",SizedBox(
                                       height: 40.w,
                                       width: 100.w,
                                       child: Center(
                                         child: TextField(
                                           maxLines: 1,
                                           style: TextStyle(fontSize: 13.sp),
                                           textAlign: TextAlign.end,
                                           decoration: const InputDecoration(
                                             border: InputBorder.none,
                                             hintText: "输入电话",
                                           ),
                                           controller: _phoneController,
                                         ),
                                       )
                                   )),
                                 ],
                               ),
                             ),


                             SizedBox( height: 5.h),

                             Container(
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.all(Radius.circular(20.w)),
                               ),
                               child:  item("个性签名", SizedBox(
                                 width: 220.w,
                                 child: BrnInputText(
                                   borderRadius: 20.w,
                                   maxHeight: 120.w,
                                   minHeight: 60.w,
                                   minLines: 1,
                                   maxLength: 200,
                                   bgColor: Colors.grey[200]!,
                                   textEditingController: _descriptionController,
                                   textInputAction: TextInputAction.newline,
                                   maxHintLines: 20,
                                   hint: "输入个性签名~",
                                   autoFocus: false,
                                   padding: EdgeInsets.all(10.w),
                                   onTextChange: (text) {},
                                   onSubmit: (text) {},
                                 ),
                               )),

                             ),
                             SizedBox(
                               height: 50.h,
                             ),
                             SizedBox(
                               width: double.infinity,
                               child: Center(
                                 child: AnimatedPress(
                                     child: OutlinedButton(
                                       style: ButtonStyle(
                                           side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                                           minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                                       ),
                                       onPressed: () async{
                                         ///触发修改个人信息事件
                                         ///获取文件的类型
                                         String? mimeType = lookupMimeType(selectedAvatar?.path??"");
                                         if(selectedAvatar != null) {
                                           submitAvatar = (
                                               MultipartFile.fromFileSync(
                                                   selectedAvatar?.path ?? "",
                                                   contentType: MediaType(
                                                       "image", mimeType?.split("/")[1] ?? "jpg")));
                                         }
                                         String gender = _gender == ""? getDefaultGender(userInfo): _gender;
                                         bool res = await UserService.modifyInfo(submitAvatar,
                                             _nicknameController.text, gender, _phoneController.text, _descriptionController.text);
                                         if(res){
                                           await UserService.getMyInfo(userInfo);
                                           CommonToast.showToast("修改成功!");
                                         }
                                       },
                                       child: Text("确认修改",
                                           style: TextStyle(color: themeColor,
                                               fontSize: 15.sp,fontWeight: FontWeight.w300)),
                                     )
                                 ),

                               ),
                             )

                           ],
                         ),


                       );
                     },
                     childCount: 1
                 ),

               )
             ],
           );

         });

  }


  Image getImage(String url){

    if(selectedAvatar != null){
      return Image.file(
        File(selectedAvatar?.path ?? ""),
        width: 56.w,
        height: 56.w,
        fit: BoxFit.cover,
      );
    }
    if(url != ""){
      return Image(
        image: NetworkImage(url),
        width: 56.w,
        height: 56.w,
        fit: BoxFit.cover,
      );
    }

    return Image(
        image: const AssetImage('assets/images/icon.jpeg'),
        fit: BoxFit.cover,
        width: 56.w,
        height: 56.w,
    );

  }

  Widget item(String title, Widget child){

    return  Padding(
         padding: EdgeInsets.only(top:10.w,bottom:10.w,left:25.w,right:25.w),
         child: Row(
           children: [
             Center(
               child: Text(title, style: TextStyle(fontSize: 14.sp,)),
             ),
             const Spacer(),
             child,
           ],
         )
       );
  }

  String getDefaultGender(UserInfo userInfo){
    switch(userInfo.gender){
      case "0": return "女";
      case "1": return "男";
    }
    return "请选择";
  }




}