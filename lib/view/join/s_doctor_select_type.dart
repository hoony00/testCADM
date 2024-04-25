import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/Enum/member_type.dart';
import '../../provider/enum/page_type.dart';
import '../../widget/w_join_next_row.dart';
import '../../widget/w_join_select_row.dart';
import '../../widget/w_linear_progress_indicator.dart';
import '../../widget/w_title.dart';

class DoctorSelectTypeScreen extends ConsumerStatefulWidget {
  const DoctorSelectTypeScreen({super.key});

  @override
  ConsumerState<DoctorSelectTypeScreen> createState() =>
      _DoctorSelectTypeScreenState();
}

class _DoctorSelectTypeScreenState
    extends ConsumerState<DoctorSelectTypeScreen> {
  MemberType selectedMemberType = MemberType.physician; // 초기 선택된 회원 유형을 지정합니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomLinearIndicator(value: 0.5),
          const JoinTitle(title: '어떤 의사인가요?'),

          // 선택 가능한 회원 유형
          SelectableMemberWidget(
            text: '전문의',
            isSelected: selectedMemberType == MemberType.physician,
            onSelect: () {
              setState(() {
                selectedMemberType = MemberType.physician;
              });
            },
          ),
          SelectableMemberWidget(
            text: '일반의',
            isSelected: selectedMemberType == MemberType.doctor,
            onSelect: () {
              setState(() {
                selectedMemberType = MemberType.doctor;
              });
            },
          ),

          //  ValueCheckButton(value1: selectedMemberType,),
          const Spacer(),
          // 다음 버튼

          JoinNextButtonRow(
            pageType: PageType.memberType,
            onSelect: () {
              context.goNamed('doctor_input_info');
            },
          ),
        ],
      ),
    );
  }
}
