import 'package:flutter/material.dart';

import '../../colors/color_palette.dart';
import '../button/custom_radius_button.dart';

class CustomModalOneButton extends StatelessWidget {
  final Text modalContent;
  final Text buttonText;
  final void Function() onButtonPressed;

  const CustomModalOneButton(
      {required this.modalContent,
      required this.buttonText,
      required this.onButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: modalContent,
      actions: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
          child: SizedBox(
              width: double.infinity,
              child: CustomRadiusButton(
                  buttonHeight: 60,
                  borderRadius: 10,
                  buttonChild: buttonText,
                  buttonBackgroundColor: ColorPalette.primaryColor,
                  onButtonPressed: onButtonPressed)),
        )),
      ],
    );
  }
}
