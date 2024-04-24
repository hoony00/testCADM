import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test04dm/view/screen/camera/s_check.dart';
import 'package:test04dm/view/screen/camera/s_upload.dart';
import 'package:test04dm/view/screen/login/s_login.dart';

import '../common/colors/color_palette.dart';
import '../provider/page_index_provider.dart';
import 'Navigation/bottom_navigation/w_convex_bottom.dart';
import 'fab/w_floating_daangn_button.dart';
import 'home/s_home.dart';
import 'join/s_join.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final indexProvider = ref.watch(pageIndexProvider);

    final List<Widget> body = [
      Visibility(visible: indexProvider == 0, child: const PickImgScreen()),
      Visibility(visible: indexProvider == 1, child: const CheckScreen()),
      Visibility(visible: indexProvider == 2, child: const HomeScreen()),
      Visibility(visible: indexProvider == 3, child: const LoginScreen()),
      Visibility(visible: indexProvider == 4, child:  JoinScreen()),
    ];

    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: indexProvider,
                children: body,
              ),
            ),
            bottomNavigationBar: const ConvexBottomNavigation(),
          ),
         // FloatingDaangnButton(),
        ],
      ),
    );
  }
}




