import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test04dm/common/font/custom_text_style.dart';
import 'package:test04dm/common/font/pretendard.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/permission/permission_util.dart';
import '../../../provider/camera/send_pic.dart';
import '../../../widget/w_join_next_row.dart';
import '../../../widget/w_linear_progress_indicator.dart';
import '../../../widget/w_one_image.dart';
import '../../../widget/w_title.dart';

class DealerUploadScreen extends ConsumerStatefulWidget {
  const DealerUploadScreen({super.key});

  @override
  ConsumerState<DealerUploadScreen> createState() => _DealerUploadScreenState();
}

//dealer_upload_info
class _DealerUploadScreenState extends ConsumerState<DealerUploadScreen> {
  bool isUploading = false;

  final ImagePicker picker = ImagePicker();

  /// 갤러리
  Future<void> pickImage(BuildContext context) async {
    print("이미지 선택 시작");

    await PermissionUtil.checkGalleryPermission(context);

    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);



    if (selectedImage != null) {
      //기존 state 제거
      ref.read(selectedImgProvider.notifier).removeAll();
      // 이미지를 선택한 경우
      setState(() {
        isUploading = true;
      });
      ref.watch(selectedImgProvider.notifier).insertCameraImg(selectedImage);
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(),
          const CustomLinearIndicator(value: 0.8),
          const JoinTitle(title: '사업자 등록증을 업로드해 주세요.\n(의료기기 판매업 포함)'),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('의료기기법 제16조 (판매업 등의 신고)', style: Pretendard.wblack2_s16_w700).pSymmetric(h: 20.w,
                  v: 15.w),
              const Text(
                  '의료기기의 판매를 업으로 하고자 하는 자(이하“판매업자”라 한다)'
                      ' 또는 임대를 업으로 하고자 하는 자(이하“임대업자”라 한다)는 영업소마다 보건복지부령이 정하는'
                      ' 바에 의하여 영업소 소재지의 시장·군수 또는 구청장에게 판매업 또는 임대업신고를 하여야 한다.',
                  style: Pretendard.wblack_s13_w400)
                  .pSymmetric(h: 20.w),
            ],
          ),
          // 제 16조(판매업 등의 신고)만 글자 크게CustomTextStyle


          FileUploadWidget(
            title: '사업자 등록증 업로드',
            onPressed: () {pickImage(context);},
          ).pSymmetric(v: 40.w),

          // 다음 버튼
          JoinNextButtonRow(
            height: ref.watch(selectedImgProvider).isEmpty ? 95.h : 40.h,
            onSelect: () {
              setState(() {
                isUploading = true;
              });
              //2초간 딜레이
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  isUploading = false;
                });
                context.goNamed('home');
              });
            },
          ),
        ],
      ),
    );
  }
}
