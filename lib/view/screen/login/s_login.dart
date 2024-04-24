import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:test04dm/common/font/pretendard.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 첫 번째 컬럼 (가운데 고정)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitle(),
                    _buildSunTilte(),
                    const SizedBox(height: 30.0),
                    _buildDescrition(),
                  ],
                ),
              ),

              // 두 번째 컬럼 (하단 고정)
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    _buildLoginButton(),
                    const SizedBox(height: 10.0),
                    _buildLoginText(),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '닥터장터',
      style: Pretendard.wPrimaryColor_s50_w900,
    );
  }

  Widget _buildSunTilte() {
    return const Text(
      '중고 의료기기 거래 플랫폼',
      style: Pretendard.wblack_s24_w700,
    );
  }

  Widget _buildDescrition() {
    return const Text(
      '닥터장터와 중고 의료기기 거래를 \n 손쉽게 시작해보세요! 👋',
      style: Pretendard.wPrimaryColor_s16_w500,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {

        //페이지 이동
        context.go('/loginCheck');

        // 버튼 클릭 시 처리할 코드 작성
        print('로그인 버튼 클릭됨');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.primaryColor,
        minimumSize: Size(400, 50),
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
        '시작하기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

    );
  }


  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('이미 계정이 있나요? '),
        GestureDetector(
          onTap: () {},
          child: const Text(
            '로그인',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
