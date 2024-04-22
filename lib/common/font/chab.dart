
import 'dart:ui';

import '../colors/color_palette.dart';
import 'custom_text_style.dart';


class Chab {
  static const fontFamily = "Chab";


  static const wblack_s18_w400 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.black, fontSize: 18.0, fontWeight: FontWeight.w400);

  static const wwhite_s12_w400 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.white, fontSize: 12.0, fontWeight: FontWeight.w400);

  static const wblack_s60_w700 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.black, fontSize: 60.0, fontWeight: FontWeight.w700);
  static const wblack_s60_w500 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.black, fontSize: 60.0, fontWeight: FontWeight.w500);

  static const wprimary_s11_w100 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.primaryColor, fontSize: 11.0, fontWeight: FontWeight.w100);

  static const wprimary_s13_w400 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.primaryColor, fontSize: 13.0, fontWeight: FontWeight.w100);
  static const wprimary_s18_w400 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.primaryColor, fontSize: 18.0, fontWeight: FontWeight.w400);
  static const wprimary_s20_w400 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.primaryColor, fontSize: 20.0, fontWeight: FontWeight.w400);
  static const wprimary_s60_w500 = CustomTextStyle(fontFamily: fontFamily, color: ColorPalette.primaryColor, fontSize: 60.0, fontWeight: FontWeight.w500);

}