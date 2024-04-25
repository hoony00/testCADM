/// 거래 권한 등록 1단계

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/font/pretendard.dart';
import '../../widget/w_linear_progress_indicator.dart';

class MemberTypeSelectionScreen extends ConsumerStatefulWidget {
  const MemberTypeSelectionScreen({super.key});

  @override
  ConsumerState<MemberTypeSelectionScreen> createState() => _MemberTypeSelectionScreenState();
}

class _MemberTypeSelectionScreenState extends ConsumerState<MemberTypeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
///todo : https://pub.dev/packages/flutter_animate 등 글자에 색상넣기, 잘 정리된 패키지에도 비슷한 기능 있음 !
          const CustomLinearIndicator(value: 0.3),
          _buildTitle(),
          const Height(500),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '어떤 회원이신가요?',
      style: Pretendard.wblack_s28_w700,
    );
  }

  Widget _buildButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFB6BFC7),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '나중에 할래요',
                  style: Pretendard.wblack_s16_w600,
                ),
              ],
            ),
          ).p8(),
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              color: Color(0xFF0052FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '다음',
                  style: Pretendard.wwhite_s16_w600,
                ),
              ],
            ),
          ).p8(),
        ),
      ],
    );
  }


}


