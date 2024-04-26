import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widget/w_linear_progress_indicator.dart';
import '../../../widget/w_title.dart';

class DealerUploadScreen extends ConsumerStatefulWidget {
  const DealerUploadScreen({super.key});


  @override
  ConsumerState<DealerUploadScreen> createState() => _DealerUploadScreenState();
}

//dealer_upload_info
class _DealerUploadScreenState extends ConsumerState<DealerUploadScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const CustomLinearIndicator(value: 0.8),
          const JoinTitle(title: '병원 정보를 입력해 주세요.'),
          Text('DealerUpload'),
        ],
      ),
    );
  }
}
