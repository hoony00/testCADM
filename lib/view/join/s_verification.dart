import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test04dm/widget/w_appBar.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/colors/color_palette.dart';
import '../../common/font/pretendard.dart';
import '../../widget/w_loding_container.dart';
import '../../widget/w_title.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {

  late TextEditingController _phoneController;
  late TextEditingController _authNumberController;
  bool isVisibilityAuthNumber = false;
  bool isUploading = false;

  @override
  void initState() {
    _phoneController = TextEditingController();
    _authNumberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppbar(isBack: true).pOnly(top: 20),
              const Height(50),
              const JoinTitle(title: '반가워요! \n본인확인을 해주세요.'),
              _buildPhoneNumber(),
              _buildAuthNumber(),
              _buildCheckButton(),
            ],
          ),
          LoadingContainer(text: '정보 확인 중...', isVisible: isUploading),
        ],
      ),
    );
  }
  
  Widget _buildPhoneNumber() {
    return Row(
      children: [
        Container(
          width: context.screenWidth * 0.54,
          height: context.screenWidth * 0.13,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
          ),

          child: TextFormField(
            /// todo : 포커스 받으면 테두리 색상 변경
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: '휴대폰 번호 입력',
              border: InputBorder.none,
            ),
          ).pOnly(left: 16),
        ).p16(),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            surfaceTintColor: Colors.white,
          ),
          onPressed: () {
            print('인증번호 확인');
            setState(() {
              isVisibilityAuthNumber = true;
            });
          },
          child:  const Text('인증번호 발송', style:  Pretendard.wblack2_s16_w500),
        ),
      ],
    );
  }

  Widget _buildAuthNumber() {
    return Visibility(
      visible: isVisibilityAuthNumber,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
        ),

        child: TextField(
          //밑에 라인 제거
          controller: _authNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: '인증번호 4자리',
            border: InputBorder.none,
          ),
        ).pOnly(left: 16),
      ).p16(),
    );
  }

  Widget _buildCheckButton() {
    return Visibility(
      visible: isVisibilityAuthNumber,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isUploading = true;
          });
          //2초간 딜레이
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isUploading = false;
            });
            context.goNamed('BusinessCheck1');

          });

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
          '다음',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ).p20(),
    );
  }
}
