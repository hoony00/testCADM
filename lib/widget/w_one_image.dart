import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:test04dm/common/font/pretendard.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/camera/send_pic.dart';

class FileUploadWidget extends ConsumerStatefulWidget {
  final VoidCallback onPressed;
  final String title;

  const FileUploadWidget({
    required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends ConsumerState<FileUploadWidget> {
  @override
  Widget build(BuildContext context) {
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
                 Text(
                  widget.title,
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
                    right: 10.w,
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
          onPressed: widget.onPressed,
          child: Text(
            '파일 선택',
            style: TextStyle(color: ColorPalette.primaryColor, fontSize: 15.sp),
          ),
        ).p16(),
      ],
    );
  }
}
