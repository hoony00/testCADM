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
    final isSmall = floatingButtonState.isSmall;
    final width = context.deviceWidth;

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
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: isExpanded ? 1 : 0,
                duration: duration,
                child: Container(
                  width: 190,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  decoration: BoxDecoration(
                    color: ColorPalette.primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _floatItem('의료장비 판매신청', 'assets/images/fab/fab_01.png'),
                      _floatItem('의료장비 경매신청', 'assets/images/fab/fab_02.png'),
                      _floatItem('의료장비 수배신청', 'assets/images/fab/fab_03.png'),
                    ],
                  ),
                ),
              ),
              Tap(
                onTap: () {
                  ref.read(floatingButtonStateProvider.notifier).onTapButton();

                },
                child: AnimatedContainer(
                  duration: duration,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color:
                    isExpanded
                        ?  ColorPalette.primaryColor.withOpacity(0.9)
                      :  ColorPalette.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedRotation(turns: isExpanded ? 0.125 : 0, duration: duration, child: const Icon(Icons.add)),
                      AnimatedWidthCollapse(
                          visible: !isSmall,
                          duration: duration,
                          child: '글쓰기'.text.make()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _floatItem(String title, String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath, width: 30),
        const Width(8),
        title.text.make(),
      ],
    );
  }
}
