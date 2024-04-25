import 'package:flutter/material.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../common/font/pretendard.dart';

class SelectableMemberWidget extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Function() onSelect;

  const SelectableMemberWidget({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  _SelectableMemberWidgetState createState() => _SelectableMemberWidgetState();
}

class _SelectableMemberWidgetState extends State<SelectableMemberWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(); // 선택 상태를 변경합니다.
      },
      child: Container(
        height: 50,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: widget.isSelected ? 2 : 1, // 선택되었을 때 보더 굵기 변경
              color: widget.isSelected ? ColorPalette.primaryColor : ColorPalette.backgroundIndicatorColor, // 선택되었을 때 보더 색상 변경
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Text(
              widget.text,
              style: Pretendard.wblack_s16_w600,
            ).px20(),
          ],
        ),
      ).p16(),
    );
  }
}
