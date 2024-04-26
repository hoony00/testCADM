import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/font/pretendard.dart';
import '../../../common/permission/permission_util.dart';
import '../../../provider/camera/send_pic.dart';
import '../../../provider/enum/page_type.dart';
import '../../../widget/w_custom_textf.dart';
import '../../../widget/w_dropdown.dart';
import '../../../widget/w_join_next_row.dart';
import '../../../widget/w_join_select_row.dart';
import '../../../widget/w_linear_progress_indicator.dart';
import '../../../widget/w_loding_container.dart';
import '../../../widget/w_title.dart';

class DoctorUploadScreen extends ConsumerStatefulWidget {
  const DoctorUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DoctorUploadScreen> createState() => _DoctorUploadScreenState();
}

class _DoctorUploadScreenState extends ConsumerState<DoctorUploadScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  String? selectedDepartment; // 선택된 진료과를 저장할 변수
  bool isUploading = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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


    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(),
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
                  hintText: '병원명',
                  width: 0.90,
                ),
                // 병원 연락처
                CustomTextField(
                  controller: _phoneController,
                  hintText: '병원 연락처',
                  keyboardType: TextInputType.phone,
                  width: 0.90,
                ),

                fileUpload(() {
                  pickImage(context);
                }),

                // 다음 버튼
                JoinNextButtonRow(
                  height: ref.watch(selectedImgProvider).isEmpty ? 80.h :20.h,
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
                    //병원 정보를 알려주세요
                  },
                ),

              ],
            ),
          ),
          LoadingContainer(text: '권한 요청 중...', isVisible: isUploading),
        ],
      ),
    );
  }

  Widget fileUpload(Function function) {
    return Column(
      children: [
        if (ref.watch(selectedImgProvider).isEmpty)
          Container(
            height: 50,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '선택된 이미지가 없습니다.',
                  style: Pretendard.wblack_s14_w500,
                ).px20(),
              ],
            ),
          ).p16(),
        if (ref.watch(selectedImgProvider).isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      image: DecorationImage(
                        image: FileImage(
                          File(ref.watch(selectedImgProvider)[0].path),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 130.w,
                    height: 140.w,
                  ),
                  Positioned(
                    top: 5.w,
                    right: 5.w,
                    child: InkWell(
                      onTap: () =>
                          ref.read(selectedImgProvider.notifier).removeImg(0),
                      child: Icon(
                        Icons.close,
                        size: 30.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ElevatedButton(
          //버튼 색 파란색
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.brightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            function();
          },
          child: Text(
            '파일 선택',
            style: TextStyle(color: ColorPalette.primaryColor, fontSize: 15.sp),
          ),
        ).p16(),

      ],
    );
  }


}
