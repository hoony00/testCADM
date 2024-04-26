import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test04dm/common/font/pretendard.dart';
import 'package:test04dm/provider/enum/page_type.dart';
import 'package:test04dm/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinNextButtonRow extends StatelessWidget {
  final Function() onSelect;
  final double height;

  const JoinNextButtonRow({
    Key? key,
    required this.onSelect,
  required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Height(height),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.goNamed('main');
                },
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                    onSelect();
                },
                child: Container(
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0052FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
            ),
          ],
        ).pOnly(top: 20.h, left: 20.h, right: 20.h),
      ],
    );
  }
}
