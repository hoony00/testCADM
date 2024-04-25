import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test04dm/common/font/pretendard.dart';
import 'package:test04dm/model/Enum/member_type.dart';
import 'package:test04dm/provider/enum/page_type.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinNextButtonRow extends StatelessWidget {
  final Function()? onSelect;
  final PageType pageType;

  const JoinNextButtonRow({
    Key? key,
    this.onSelect,
    required this.pageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              if (pageType == PageType.memberType) {
                onSelect!();
              }
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
    ).pOnly(top: 20.0, left: 20.0, right: 20.0, bottom: 110.0);
  }
}
