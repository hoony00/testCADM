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
import '../../../widget/w_one_image.dart';
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

      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.gallery);

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    options: [
                      '내과',
                      '소아과',
                      '피부과',
                      '성형외과',
                      '산부인과',
                      '안과',
                      '가정의학과',
                      '정형외과',
                      '이비인후과',
                      '치과',
                      '재활의학과',
                      '기타'
                    ],
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

                  FileUploadWidget(
                    title: '의사 면허증 사본 업로드',
                    onPressed: () {pickImage(context);},
                  ),

                  // 다음 버튼
                  JoinNextButtonRow(
                    height:
                        ref.watch(selectedImgProvider).isEmpty ? 90.h : 20.h,
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
            ),
            LoadingContainer(text: '권한 요청 중...', isVisible: isUploading),
          ],
        ),
      ),
    );
  }
}
