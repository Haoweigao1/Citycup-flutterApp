import 'package:flutter/material.dart';
import 'package:meta_transaction/config/application.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("注册"),
      ),
      // child: PageContent(name: "登录"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
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
                decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: !showPassword,
                decoration: const InputDecoration(
                  labelText: "确认密码",
                  hintText: "请再次输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("注册"),
                  onPressed: () {
                    print("register");
                  },
                ),
              ),
              const SizedBox(
                height: 16,
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
      ),
    );
  }

}

