import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../provider/enum/page_type.dart';
import '../../widget/w_custom_textf.dart';
import '../../widget/w_dropdown.dart';
import '../../widget/w_join_next_row.dart';
import '../../widget/w_linear_progress_indicator.dart';
import '../../widget/w_title.dart';

class DoctorInputScreen extends ConsumerStatefulWidget {
  const DoctorInputScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DoctorInputScreen> createState() => _DoctorInputScreenState();
}

class _DoctorInputScreenState extends ConsumerState<DoctorInputScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  String? selectedDepartment; // 선택된 진료과를 저장할 변수

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomLinearIndicator(value: 0.8),
          const JoinTitle(title: '병원 정보를 입력해 주세요.'),

          // 진료과 선택
          CustomDropdownField(
            hintText: '진료과를 선택해주세요',
            options: ['내과', '외과', '정형외과', '피부과', '치과'],
            selectedOption: selectedDepartment,
            onChanged: (String? newValue) {
              setState(() {
                selectedDepartment = newValue;
              });
            },
          ),
          // 병원명 선택
          CustomTextField(
            controller: _nameController,
            hintText: '병원명을 입력해주세요',
            width: 0.90,
          ),
          // 병원 연락처
          CustomTextField(
            controller: _phoneController,
            hintText: '병원 연락처를 입력해주세요',
            keyboardType: TextInputType.phone,
            width: 0.90,
          ),

          const Spacer(),
          // 다음 버튼
          JoinNextButtonRow(
            pageType: PageType.memberType,
            onSelect: () {
              //병원 정보를 알려주세요
              context.goNamed('/join/hospital_info');
            },
          ),
        ],
      ),
    );
  }
}
