import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String authToken = ''; // 存储密钥
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Future<String?> getAuthToken() async {
    // TODO: 从服务器或本地存储中获取最新的密钥
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> login() async {
    print('login');
    Dio dio = Dio();
    Response response = await dio.get('http://47.115.228.176:80/User/login',data: {'username':'${_usernameController.text}', 'password':"${_passwordController.text}",}
    );

    // 将最新密钥存储到SharedPreferences中
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', authToken);
    print(response.data);
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: Colors.greenAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      )),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      )),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        login();
                      },
                      child: const Text('登录'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('注销'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}