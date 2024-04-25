import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/model/Enum/member_type.dart'; // Enum을 import합니다.
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/font/pretendard.dart';
import '../../widget/w_join_next_row.dart';
import '../../widget/w_join_select_row.dart';
import '../../widget/w_linear_progress_indicator.dart';
import '../../widget/w_title.dart';
import '../../widget/w_value_check_button.dart';

class MemberTypeSelectionScreen extends StatefulWidget {
  const MemberTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  _MemberTypeSelectionScreenState createState() =>
      _MemberTypeSelectionScreenState();
}

class _MemberTypeSelectionScreenState extends State<MemberTypeSelectionScreen> {
  MemberType selectedMemberType = MemberType.doctor; // 초기 선택된 회원 유형을 지정합니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomLinearIndicator(value: 0.2),
          const JoinTitle(title: '어떤 회원이신가요?'),

          // 선택 가능한 회원 유형
          SelectableMemberWidget(
            text: '개인 판매업자',
            isSelected: selectedMemberType == MemberType.dealer,
            onSelect: () {
              setState(() {
                selectedMemberType = MemberType.dealer;
              });
            },
          ),
          SelectableMemberWidget(
            text: '의사 회원',
            isSelected: selectedMemberType == MemberType.doctor,
            onSelect: () {
              setState(() {
                selectedMemberType = MemberType.doctor;
              });
            },
          ),

          ValueCheckButton(),
          Spacer(),
          // 다음 버튼
          JoinNextButtonRow(
            nextScreenName: 'test',
          ),
        ],
      ),
    );
  }
}
