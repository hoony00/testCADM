import 'package:flutter/material.dart';
import 'package:test04dm/common/font/pretendard.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinNextButtonRow extends StatelessWidget {
  const JoinNextButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFB6BFC7),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '나중에 할래요',
                  style: Pretendard.wblack_s16_w600,
                ),
              ],
            ),
          ).p8(),
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: ShapeDecoration(
              color: Color(0xFF0052FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '다음',
                  style: Pretendard.wwhite_s16_w600,
                ),
              ],
            ),
          ).p8(),
        ),
      ],
    ).p8();
  }
}
