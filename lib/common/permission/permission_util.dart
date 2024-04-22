import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/modal/custom_modal_one_button.dart';
import '../font/pretendard.dart';

class PermissionUtil {

  /// 코드 이쪽으로 옮기고 권한 요청 페이지 , 플로우만 좀 다듬자 오케이 , 카카오톡 살짝 참고하자
  /// 메디신 페이지, 갤러리보드 페이지, 갤러리보드 -> 카메라 선택 블록

  // 카메라 권한 체크
  static Future<bool> checkCameraPermission(BuildContext context, bool mounted) async {
    // 최초 권한 요청 후 권한 상태 값 반환
    final cameraPermissionStatus = await Permission.camera.request();
    if (!mounted) return false;

    if(cameraPermissionStatus.isGranted) {
      return true;
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return CustomModalOneButton(
            modalContent: const Text(
                "카메라 권한 동의를 허용해주셔야 \n사진 촬영이 가능합니다. \n원할한 서비스 이용을 위해 권한을 \n허용해주세요 :)"),
            buttonText: const Text(
              "설정창으로 이동",
              style: Pretendard.wwhite_s16_w600,
            ),
            onButtonPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          );
        },
      );
      return false;
    }
  }


  // 갤러리보드 권한 체크 ( 운영체제 고려 )
  static Future<bool> checkGalleryPermission(BuildContext context, bool mounted) async {
    // 최초 권한 요청 후 권한 상태 값 반환
    final galleryPermissionStatus = Platform.isAndroid ? await checkAndroidPermission() : await Permission.photos.request();
    if (!mounted) return false;

    if(galleryPermissionStatus.isGranted) {
      return true;
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return CustomModalOneButton(
            modalContent: const Text(
                "저장공간 접근 권한 동의를 허용해주셔야 \n이미지 이용이 가능합니다. \n원할한 서비스 이용을 위해 권한을 \n허용해주세요 :)"),
            buttonText: const Text(
              "설정창으로 이동",
              style: Pretendard.wwhite_s16_w600,
            ),
            onButtonPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          );
        },
      );
      return false;
    }

  }

  static Future<PermissionStatus> checkAndroidPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
     return await Permission.storage.request();
    } else {
      return await Permission.photos.request();
    }
  }


  static Future<bool> checkPermission() async {
    // Permission.notification.request().then((value) => null);
    // Android
    if (Platform.isAndroid) {
      final permissions = await Future.wait([
        Permission.storage.status,
        Permission.camera.status,
        Permission.notification.status
      ]);
    } else { // IOS
      final permissions = await Future.wait([
        Permission.photos.status,
        Permission.camera.status,
        Permission.notification.status,
        Permission.appTrackingTransparency.status,
      ]);
    }
    return true;
  }
}
