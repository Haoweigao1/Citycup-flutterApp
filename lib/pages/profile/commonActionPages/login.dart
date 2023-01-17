import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_transaction/config/application.dart';
import 'package:provider/provider.dart';

import '../../../model/application/applicationViewModel.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/animation/pressAnimation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
      body: const SafeArea(child: LoginPageBody())
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
  @override
  Widget build(BuildContext context) {

    Color themeColor = isDarkMode(context)? Theme.of(context).primaryColor.withAlpha(155)
        : Theme.of(context).primaryColor;

    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Column(
              children:[
                SizedBox(
                  height: 24.w,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "账号",
                    hintText: "请输入账号",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                TextField(
                  obscureText: !showPassword,
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
                  child: Container(
                    width: double.infinity,
                    child: const Text(
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
                    AnimatedPress(
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(color: themeColor)),
                              minimumSize: MaterialStateProperty.all(Size(100.w, 40.w)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)))
                          ),
                          onPressed: () {

                          },
                          child: Text("登录",
                              style: TextStyle(color: themeColor,
                                  fontSize: 15.sp,fontWeight: FontWeight.w300)),
                        )
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
                )
              ],
            ),
          ),
        );
      },
    );

  }

}
