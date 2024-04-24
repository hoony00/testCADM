import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/colors/color_palette.dart';
import '../../../provider/page_index_provider.dart';

class ConvexBottomNavigation extends ConsumerStatefulWidget {
  const ConvexBottomNavigation({super.key});

  @override
  ConsumerState<ConvexBottomNavigation> createState() =>
      _ConvexBottomNavigationState();
}

class _ConvexBottomNavigationState
    extends ConsumerState<ConvexBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final indexProvider = ref.watch(pageIndexProvider);

    final height = context.screenHeight;

    return ConvexAppBar.badge(
      {
      },
        gradient: const LinearGradient(
          colors: [ColorPalette.primaryColor, ColorPalette.secondColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      top: -20,
      style: TabStyle.react,
      badgeMargin: EdgeInsets.only(left: height * 0.028, bottom: height * 0.04),
      backgroundColor: ColorPalette.secondColor,
      elevation: 4,
// 버튼 모양


      items: const [
        TabItem(icon: Icons.more_time_outlined, title: '업로드'),
        TabItem(icon: Icons.sports_gymnastics_outlined, title: '다운로드'),
        TabItem(icon: Icons.home, title: 'home'),
        TabItem(icon: Icons.login, title: '로그인'),
        TabItem(icon: Icons.join_full, title: '회원가입'),
      ],

      // 초기값
      initialActiveIndex: indexProvider,

      onTap: (int i) {

        // 화면 이동
        ref.read(pageIndexProvider.notifier).state = i;
      },
    );
  }
}

class ConvexStyleProvider extends StyleHook {
  late double height;

  ConvexStyleProvider({required this.height});

  @override
  double get activeIconSize => height * 0.05;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => height * 0.03;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(
        color: color, fontSize: height * 0.016, fontFamily: fontFamily);
  }
}


