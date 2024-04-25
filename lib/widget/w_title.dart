import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../common/font/pretendard.dart';

class JoinTitle extends StatelessWidget {
  final String title;
  const JoinTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return  Text(
      title,
      style: Pretendard.wblack_s24_w700,
    ).pOnly(left: width * 0.05);
  }
}
