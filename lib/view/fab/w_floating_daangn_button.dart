import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/common/colors/color_palette.dart';
import 'package:test04dm/common/extension/context_extension.dart';
import 'package:test04dm/common/extension/num_duration_extension.dart';
import 'package:test04dm/view/fab/w_floating_daangn_button.riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/animated_width_collapse.dart';
import '../../widget/w_height_and_width.dart';
import '../../widget/w_tap.dart';

class FloatingDaangnButton extends ConsumerWidget {
  FloatingDaangnButton({super.key}); // 컨스트 포기하고 ms 사용

  final duration = 300.ms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floatingButtonState = ref.watch(floatingButtonStateProvider);
    final isExpanded = floatingButtonState.isExpanded;
    final width = context.deviceWidth;

    void onTapButton() {
      ref.read(floatingButtonStateProvider.notifier).onTapButton();
    }

    return Stack(
      children: [
        IgnorePointer(
          ignoring: !isExpanded,
          child: AnimatedContainer(
            duration: duration,
            color:
            isExpanded ? Colors.black.withOpacity(0.4) : Colors.transparent,
          ),
        ),
        Align(
          // 오른쪽 아래
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: isExpanded ? 1 : 0,
                duration: duration,
                /// 확장된 컨테이너 UI
                child: Container(
                  width: 190,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  decoration: BoxDecoration(
                    color: ColorPalette.primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _floatItem('의료장비 판매신청', 'assets/images/fab/fab_01.png'),
                      _floatItem('의료장비 수배신청', 'assets/images/fab/fab_03.png'),
                    ],
                  ),
                ),
              ),
              Tap(
                onTap: () {
                  onTapButton();
                },
                child: AnimatedContainer(
                  duration: duration,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color:
                        ///동적 색상 변경
                    isExpanded
                        ?  ColorPalette.primaryColor.withOpacity(0.9)
                      :  ColorPalette.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///동적 아이콘 변경
                      AnimatedRotation(turns: isExpanded ? 0.125 : 0, duration: duration,
                          child: const Icon(Icons.add)),
                      AnimatedWidthCollapse(
                          visible: !isExpanded,
                          duration: duration,
                          child: '글쓰기'.text.make()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).pOnly(right: 15, bottom: 100),
      ],
    );
  }

  _floatItem(String title, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(imagePath, width: 30),
        title.text.make(),
      ],
    );
  }
}
