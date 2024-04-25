import 'package:flutter/material.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomLinearIndicator extends StatelessWidget {
  final double value;
  const CustomLinearIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return  LinearProgressIndicator(
      value: value,
      backgroundColor: ColorPalette.backgroundIndicatorColor,
      valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.primaryColor),
    ).p24();
  }
}
