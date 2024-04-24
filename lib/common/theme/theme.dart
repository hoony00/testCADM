import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/color_palette.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.blue,
      displayColor: Colors.black,
      fontFamily: "Pretendard",
      //
      fontSizeFactor: ScreenUtil().setSp(1),

    ),
    primarySwatch: Colors.blue,
    primaryColor: ColorPalette.primaryColor, // ColorPalette가 다른 곳에서 정의되었다고 가정합니다.
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
