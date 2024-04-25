/// 거래 권한 등록 1단계

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/font/pretendard.dart';
import '../../widget/w_join_next_row.dart';
import '../../widget/w_linear_progress_indicator.dart';
import '../../widget/w_title.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
///todo : https://pub.dev/packages/flutter_animate 등 글자에 색상넣기, 잘 정리된 패키지에도 비슷한 기능 있음 !
          const CustomLinearIndicator(value: 0.3),
          const JoinTitle(title: '어떤 회원이신가요?'),
          const Height(500),
          JoinNextButtonRow(),
        ],
      ),
    );
  }




}


