import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/config/application.dart';
import 'package:meta_transaction/service/user_service.dart';
import 'package:meta_transaction/util/common_util.dart';
import 'package:meta_transaction/widgets/action_button/countdown_button.dart';

import '../../../theme/app_theme.dart';
import '../../../util/common_toast.dart';
import '../../../widgets/animation/press_animation.dart';

class RegisterPage extends StatelessWidget{
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("注册"),
          backgroundColor: isDarkMode(context)
              ? Theme.of(context).primaryColor.withAlpha(155)
              : Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: const SafeArea(child: RegisterPageBody())
    );
  }

}



class RegisterPageBody extends StatefulWidget{

  const RegisterPageBody({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageBodyState();
}


class _RegisterPageBodyState extends State<RegisterPageBody>{
  bool showPassword = false;

  late TextEditingController emailController;
  late TextEditingController pwdController;
  late TextEditingController confirmPwdController;
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    pwdController = TextEditingController();
    confirmPwdController = TextEditingController();
    codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

     return Container(
       decoration: const BoxDecoration(
           image: DecorationImage(
               image: AssetImage("assets/images/bg.jpg"),
               fit: BoxFit.fill
           )
       ),
       child: Padding(
         padding: EdgeInsets.all(30.w),
         child: Column(
           children: [
             Image(image: const AssetImage("assets/images/logo-removebg.png"),width: 150.w,),
             TextField(
               controller: emailController,
               decoration: const InputDecoration(
                 labelText: "邮箱",
                 hintText: "请输入邮箱",
                 prefixIcon: Icon(Icons.email),
               ),
             ),
             SizedBox(
               height: 16.w,
             ),
             TextField(
               obscureText: !showPassword,
               controller: pwdController,
               decoration: InputDecoration(
                 labelText: "密码",
                 hintText: "请输入密码",
                 prefixIcon: const Icon(Icons.lock),
                 suffixIcon: IconButton(
                   icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                   onPressed: () {
                     setState(() {
                       showPassword = !showPassword;
                     });
                   },
                 ),
               ),
             ),
             SizedBox(
               height: 16.w,
             ),
             TextField(
               obscureText: !showPassword,
               controller: confirmPwdController,
               decoration: InputDecoration(
                 labelText: "确认密码",
                 hintText: "请再次输入密码",
                 prefixIcon: const Icon(Icons.lock),
                 suffixIcon: IconButton(
                   icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                   onPressed: () {
                     setState(() {
                       showPassword = !showPassword;
                     });
                   },
                 ),
               ),
             ),
             SizedBox(
               height: 16.w,
             ),
             ///验证码输入模块
             Row(
               children: [
                 SizedBox(
                   width: 120.w,
                   child:TextField(
                   controller: codeController,
                   decoration: const InputDecoration(
                     labelText: "验证码",
                     hintText: "请输入验证码",
                   ),
                 ),
                 ),

                  SizedBox(
                    width: 50.w,
                  ),
                  CountdownButton(onTapCallback: (){
                    ///发送验证码
                    if(emailController.text == ""){
                      CommonToast.showToast("邮箱不能为空！");
                      return;
                    }
                    if(!checkEmail(emailController.text)){
                      CommonToast.showToast("邮箱格式不正确!");
                      return;
                    }
                    //发送
                    UserService.sendCode(emailController.text);
                  })
               ],
             ),
             SizedBox(
               height: 36.w,
             ),
             SizedBox(
               //width: double.infinity,
               child:AnimatedPress(
                   child: OutlinedButton(
                     style: ButtonStyle(
                         alignment: Alignment.center,
                         side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                         minimumSize: MaterialStateProperty.all(Size(180.w, 50.w)),
                         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                     ),
                     onPressed: () {
                       ///触发注册事件
                       if(pwdController.text != confirmPwdController.text){
                         CommonToast.showToast("两次密码输入不一致！");
                         return;
                       }
                       if(emailController.text == ""){
                         CommonToast.showToast("邮箱不能为空！");
                         return;
                       }
                       if(codeController.text == ""){
                         CommonToast.showToast("验证码不能为空！");
                         return;
                       }
                       UserService.register(emailController.text, pwdController.text, codeController.text);

                     },
                     child: Text("注册",
                         style: TextStyle(color: themeColor,
                             fontSize: 15.sp,fontWeight: FontWeight.w300)),
                   )
               ),

             ),
             SizedBox(
               height: 16.w,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Text('已有账号，'),
                 TextButton(
                   child: const Text('去登录～', style: TextStyle(color: Colors.teal),
                   ),
                   onPressed: () {
                     Application.router.navigateTo(context, '/login');
                   },
                 )
               ],
             ),
           ],
         ),
       ),
     );
  }

}

