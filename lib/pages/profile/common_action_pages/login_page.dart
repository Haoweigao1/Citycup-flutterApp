
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/config/application.dart';
import 'package:meta_transaction/model/user_info.dart';
import 'package:meta_transaction/service/user_service.dart';
import 'package:meta_transaction/util/common_toast.dart';
import 'package:provider/provider.dart';

import '../../../model/application/applicationViewModel.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/animation/press_animation.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
        backgroundColor: isDarkMode(context)
            ? Theme.of(context).primaryColor.withAlpha(155)
            : Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: const SafeArea(child: LoginPageBody()),
      resizeToAvoidBottomInset: false,
    );
  }

}


class LoginPageBody extends StatefulWidget{

  const LoginPageBody({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody>{

  bool showPassword = false;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
             image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.fill
             )
          ),
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Column(
              children:[
                Image(image: const AssetImage("assets/images/logo-removebg.png"),width: 150.w,),

                SizedBox(
                  height: 10.w,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "邮箱",
                    hintText: "请输入邮箱",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                TextField(
                  obscureText: !showPassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          showPassword ? Icons.visibility_off : Icons.visibility),
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
                GestureDetector(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "忘记密码",
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  onTap: () {
                    debugPrint("找回密码被点击");
                  },
                ),
                SizedBox(
                  height: 16.w,
                ),
                //登录和注册按钮横向排布
                Row(
                  children: [
                    Consumer<UserInfo>(
                    builder: (_, userInfo, child) {
                      return  AnimatedPress(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(themeColor),
                                side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                                minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                            ),
                            onPressed: () async{
                              ///触发登录事件
                              if(_emailController.text != "" && _passwordController.text != ""){
                                //将用户信息写入provider
                                bool res = await UserService.login(_emailController.text, _passwordController.text, userInfo,applicationViewModel);
                                //返回到上一个页面
                                if(res && mounted){
                                  CommonToast.showToast("登录成功");
                                  Navigator.pop(context);
                                }
                              }else{
                                CommonToast.showToast("邮箱或密码不能为空！");
                              }
                            },
                            child: Text("登录",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 15.sp,fontWeight: FontWeight.w300)),
                          )
                      );
                    }
                    ),

                    //调节两个按钮间的空隙
                    SizedBox(
                      width: 100.w,
                    ),
                    AnimatedPress(
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                              minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                          ),
                          onPressed: () {
                             Application.router.navigateTo(context, '/register');
                          },
                          child: Text("注册",
                              style: TextStyle(color: themeColor,
                                  fontSize: 15.sp,fontWeight: FontWeight.w300)),
                        )
                     ),
                  ],
                ),



              ],
            ),
          ),
        );
      },
    );

  }

}
