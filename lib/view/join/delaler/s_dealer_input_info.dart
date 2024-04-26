import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/enum/page_type.dart';
import '../../../widget/w_custom_textf.dart';
import '../../../widget/w_join_next_row.dart';
import '../../../widget/w_linear_progress_indicator.dart';
import '../../../widget/w_title.dart';

class DealerInputScreen extends ConsumerStatefulWidget {
  const DealerInputScreen({super.key});


  @override
  ConsumerState<DealerInputScreen> createState() => _DealerInputState();
}
//dealer_upload_info
class _DealerInputState extends ConsumerState<DealerInputScreen> {

  late final TextEditingController _businessNameController;
  late final TextEditingController _businessNumberController;

  @override
  void initState() {
    _businessNameController = TextEditingController();
    _businessNumberController = TextEditingController();
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
          const CustomLinearIndicator(value: 0.5),
          const JoinTitle(title: '사업자명과 사업자 등록번호를 \n입력해 주세요.'),

          CustomTextField(
            controller: _businessNameController,
            hintText: '사업자명 입력',
            width: 0.90,
          ),
          // 병원 연락처
          CustomTextField(
            controller: _businessNumberController,
            hintText: '사업자 등록 번호 입력',
            keyboardType: TextInputType.phone,
            width: 0.90,
          ),

          // 다음 버튼
          JoinNextButtonRow(
            height: 300.h,
            onSelect: () {
                context.goNamed('dealer_upload_info');
            },
          ),
        ],
      ),
    );
  }
}
