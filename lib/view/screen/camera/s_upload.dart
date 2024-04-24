import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/permission/permission_util.dart';
import '../../../provider/camera/send_pic.dart';
import '../../../provider/enum/upload_status.dart';
import '../../../widget/w_loding_container.dart';

class PickImgScreen extends ConsumerStatefulWidget {
  const PickImgScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickImgState();
}

class _PickImgState extends ConsumerState<PickImgScreen> {
  bool isUploading = false;

  final ImagePicker _picker = ImagePicker();

  /// 갤러리
  Future pickImages(BuildContext context) async {
    print("이미지 선택 시작");

    await PermissionUtil.checkGalleryPermission(context);

    final List<XFile> selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      // 기존에 리스트에 붙히기
      setState(() {
        isUploading = true;
      });
      ref.watch(selectedImgProvider.notifier).insertImg(selectedImages);
      setState(() {
        isUploading = false;
      });
    }
  }

  /// 카메라
  Future picCamera() async {
    print("카메라 선택 시작");

    await PermissionUtil.checkCameraPermission(context);

    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      // 기존에 리스트에 붙히기
      setState(() {
        isUploading = true;
      });
      ref.watch(selectedImgProvider.notifier).insertImg([selectedImage]);
      setState(() {
        isUploading = false;
      });
    } else {
      return;
    }
  }

  // 업로드
  void upload() async {
    setState(() {
      isUploading = true;
    });
    await ref.watch(selectedImgProvider.notifier).upload();
    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedImgNotifier = ref.watch(selectedImgProvider.notifier);
    final selectedImages = ref.watch(selectedImgProvider);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (ref.watch(selectedImgProvider).isEmpty)
              Text(
                '선택된 이미지가 없습니다.',
                style: TextStyle(fontSize: 30.h),
              ),
            if (ref.watch(selectedImgProvider).isNotEmpty)
              Row(
                children: [
                  SizedBox(width: 5.w),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var i = 0; i < selectedImages.length; i++)
                                Stack(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.w),
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(selectedImages[i].path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 130.w,
                                      height: 140.w,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () =>
                                            selectedImgNotifier.removeImg(i),
                                        child: const Icon(
                                          Icons.close,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () => upload(),
                    child: const Text(
                      '업로드',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      // 모든 사진 제거
                      selectedImgNotifier.removeAll();
                    },
                    child: const Text(
                      '전체 삭제',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      // 모든 사진의 확장자 표시
                      print(selectedImages.map((e) => e.path));
                    },
                    child: const Text(
                      '확장자 확인(PC)',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => pickImages(context),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.photo,
                        size: 60,
                      ),
                      Text('갤러리'),
                    ],
                  ),
                ),
                SizedBox(width: 50.w),
                InkWell(
                  onTap: () async {
                    picCamera();
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 60,
                      ),
                      Text('카메라'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        isUploading
            ? const LoadingContainer(text: '업로드 중...')
            : const SizedBox(),
      ],
    );
  }
}
