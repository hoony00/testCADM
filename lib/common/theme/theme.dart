import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/color_palette.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
      //일반 텍스트 색상
      bodyColor: ColorPalette.textColor,
      //제목 및 헤더
      displayColor: Colors.black,
      // 앱에서 사용할 글꼴
      fontFamily: "Pretendard",
      // 모든 텍스트의 크기를 증가시키는 추가 픽셀
      fontSizeDelta: 1.0,

    ),
    iconTheme: const IconThemeData(
      color: ColorPalette.iconColor, // Set th
    ),
    //앱의 주요 색상 팔레트
    primarySwatch: Colors.blue,
    //앱의 주요 색상을 정의
    primaryColor: ColorPalette.primaryColor,
    //앱의 밝기 테마
    brightness: Brightness.light,
  );
}
