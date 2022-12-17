import 'package:flutter/material.dart';
import 'package:meta_transaction/config/application.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
      ),
      // child: PageContent(name: "登录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children:[
              const SizedBox(
                height: 24,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "账号",
                  hintText: "请输入账号",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 16,
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
              const SizedBox(
                height: 16,
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
                  print("找回密码被点击");
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("登录"),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("注册"),
                  onPressed: () {
                    Application.router.navigateTo(context, '/register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
