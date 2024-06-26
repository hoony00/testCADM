import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nav/nav.dart';
import 'package:test04dm/common/extension/context_extension.dart';
import 'package:test04dm/view/home/s_home.dart';
import 'package:test04dm/view/join/delaler/s_dealer_input_info.dart';
import 'package:test04dm/view/join/delaler/s_dealer_upload_info.dart';
import 'package:test04dm/view/join/doctor/s_doctor_upload.dart';
import 'package:test04dm/view/join/doctor/s_doctor_select_type.dart';
import 'package:test04dm/view/join/s_member_type_selection.dart';
import 'package:test04dm/view/main_page.dart';
import 'package:test04dm/view/screen/login/vo_login_check.dart';


import 'common/colors/color_palette.dart';
import 'common/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});


  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with  WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final GoRouter _router = GoRouter(
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '페이지가 삭제되거나 유효하지 않습니다.',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('홈으로 이동')),
              ],
            ),
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            name: 'loginCheck',
            path: 'loginCheck',
            builder: (context, state) => const LoginCheck(),
            routes: [
              GoRoute(
                name: 'MemberTypeSelectionScreen',
                path: 'MemberTypeSelectionScreen',
                builder: (context, state) =>  MemberTypeSelectionScreen(),
                routes: [
                  ///---------------의사
                  GoRoute(
                    name: 'doctor_select_type',
                    path: 'doctor_select_type',
                    builder: (context, state) =>  DoctorSelectTypeScreen(),
                    routes: [
                      GoRoute(
                        name: 'doctor_upload_info',
                        path: 'doctor_upload_info',
                        builder: (context, state) =>  DoctorUploadScreen(),
                      ),
                    ],
                  ),
                  ///---------------업자
                  GoRoute(
                    name: 'dealer_input_info',
                    path: 'dealer_input_info',
                    builder: (context, state) =>  DealerInputScreen(),
                    routes: [
                      GoRoute(
                        name: 'dealer_upload_info',
                        path: 'dealer_upload_info',
                        builder: (context, state) =>  DealerUploadScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: 'home',
            path: 'home',
            builder: (context, state) =>  HomeScreen(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double width = context.deviceWidth;
    double height = context.deviceHeight;

    return ScreenUtilInit(
      designSize: Size(width, height),
      child: MaterialApp.router(
        showPerformanceOverlay: false,
        theme: buildThemeData(context),
        //라우트 상태를 전달해주는 함수
        routeInformationProvider: _router.routeInformationProvider,
        // routeInformationParser에서 변환된 값을 어떤 라우트로 보여줄 지 정하는 함수
        routeInformationParser: _router.routeInformationParser,
        //URI String을 상태 및 GoRouter에서 사용할 수 있는 형태로 변환해주는 함수
        routerDelegate: _router.routerDelegate,
      //  theme: ThemeData(),
        //  debugShowMaterialGrid: true, -> 그리드로 디자인 보여줌
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden: //Flutter 3.13 이하 버전을 쓰신다면 해당 라인을 삭제해주세요.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
