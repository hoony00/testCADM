import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  final bool isBack;

  const CustomAppbar({Key? key, this.title, this.isBack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(
        title!,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ) : null,
      automaticallyImplyLeading: isBack, // true면 뒤로가기 기능 표시, false면 숨김
      leading: isBack ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ) : null,
    );
  }
}
