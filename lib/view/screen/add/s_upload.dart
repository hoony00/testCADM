import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/permission/permission_util.dart';
import '../../../provider/camera/send_pic.dart';

class PickImg extends ConsumerStatefulWidget {
  const PickImg({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickImgState();
}

class _PickImgState extends ConsumerState<PickImg> {
  final ImagePicker _picker = ImagePicker();

  Future pickImages(BuildContext context) async {
    print("이미지 선택 시작");

    await PermissionUtil.checkGalleryPermission2(context);

      final List<XFile> selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // 기존에 리스트에 붙히기
        ref.watch(selectedImgProvider.notifier).insertImg(selectedImages);
      }
  }

  // 업로드
  void upload() {
    ref.watch(selectedImgProvider.notifier).upload();
  }

  Future<void> checkPermission() async {
    PermissionStatus status = await Permission.photos.status;

    print("현재 권한 상태 : $status");
  }

  @override
  void initState() {

    checkPermission();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5.w),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (var i = 0;
                        i < ref
                            .watch(selectedImgProvider)
                            .length;
                        i++)
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.w),
                                  image: DecorationImage(
                                    image: FileImage(File(ref
                                        .watch(selectedImgProvider)[i]
                                        .path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 80.w,
                                height: 80.w,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () =>
                                      ref
                                          .watch(selectedImgProvider.notifier)
                                          .removeImg(i),
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
     Column(
       children: [
         ElevatedButton(
           onPressed: () =>
               ref.watch(selectedImgProvider.notifier).upload(),
           child: Text('업로드  '),
         ),
         ElevatedButton(
           onPressed: () {
             // 모든 사진의 확장자 표시
             print(
                 ref.watch(selectedImgProvider).map((e) => e.path));
           },
           child: Text('확장자 표시'),
         ),
         ElevatedButton(
           onPressed: () {
             // 모든 사진 제거
             ref.watch(selectedImgProvider.notifier).removeAll();
           },
           child: Text('삭제'),
         ),
       ],
     ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          InkWell(
            onTap: () => pickImages(context),
            child: const Icon(Icons.photo, size: 60,),
          ),
          SizedBox(width: 50.w),
          InkWell(
            onTap: () async {
              XFile? selectedImages = await _picker.pickImage(source: ImageSource.camera);
              if (selectedImages != null) {
                ref
                    .watch(selectedImgProvider.notifier)
                    .insertCameraImg(selectedImages);
              }else{
                return;
              }
            },
            child: const Icon(Icons.camera_alt, size: 60,),
          ),
        ],)
      ],
    );
  }
}
