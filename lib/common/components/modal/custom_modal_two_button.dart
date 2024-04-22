import 'package:flutter/material.dart';

import '../../colors/color_palette.dart';
import '../button/custom_radius_button.dart';

class CustomModalTwoButton extends StatelessWidget {
  final Text modalContent;
  final Text leftButtonText;
  final Text rightButtonText;
  final void Function() onLeftButtonPressed;
  final void Function() onRightButtonPressed;

  const CustomModalTwoButton(
      {required this.modalContent,
      required this.leftButtonText,
      required this.rightButtonText,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: modalContent,
      actions: [
        SizedBox(
        width: double.infinity,
        child: CustomRadiusButton(
            buttonHeight: 60,
            borderRadius: 10,
            buttonChild: leftButtonText,
            buttonBackgroundColor: ColorPalette.primaryColor,
            onButtonPressed: onLeftButtonPressed)),
        SizedBox(
            width: double.infinity,
            child: CustomRadiusButton(
                buttonHeight: 60,
                borderRadius: 10,
                buttonChild: rightButtonText,
                buttonBackgroundColor: ColorPalette.primaryColor,
                onButtonPressed: onRightButtonPressed)),
      ],
    );
  }
}
