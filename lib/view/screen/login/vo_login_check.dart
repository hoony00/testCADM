import 'package:flutter/material.dart';
import 'package:test04dm/view/home/s_home.dart';
import 'package:test04dm/view/screen/login/s_login.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    // 로그인 정보가 있는지 여부를 확인
    final isLoggedIn = true; //

    // 로그인 여부에 따라 다른 페이지로 이동
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}

