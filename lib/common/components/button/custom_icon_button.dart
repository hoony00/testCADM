

// 값을 입력받아 동적으로 만들어지는 컴포넌트들에 custom 붙이자
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final double diameter;
  final IconData iconData;
  final Color? iconColor;
  final void Function()? onTap;

  const CustomIconButton({
    required this.diameter,
    required this.iconData,
    this.onTap,
    this.iconColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: Icon(iconData, color: iconColor,),
      ),
    );
  }
}
