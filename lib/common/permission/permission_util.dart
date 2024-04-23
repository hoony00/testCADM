import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/modal/custom_modal_one_button.dart';
import '../font/pretendard.dart';

class PermissionUtil {
  static Future<PermissionStatus> checkGalleryPermission2(BuildContext context) async {
    PermissionStatus status = Platform.isAndroid
        ? await Permission.storage.status
        : await Permission.photos.status;

    print(" 현재 라이브러리 권한 상태 : $status");

    if (status.isDenied || status.isPermanentlyDenied) {
      PermissionStatus galleryPermissionStatus = PermissionStatus.denied; // 초기값 설정
      if (Platform.isAndroid) {
        galleryPermissionStatus = await checkAndroidPermission();
      } else {
        galleryPermissionStatus = await Permission.photos.request();
      }

      if (galleryPermissionStatus.isDenied || galleryPermissionStatus.isPermanentlyDenied) {
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
      }
    }

    return status;
  }

  static Future<PermissionStatus> checkGalleryPermission(BuildContext context, bool mounted) async {
    PermissionStatus status = await Permission.photos.status;
    if (!mounted) return status;

    print(" 현재 권한 상태 : $status");

    if (status.isDenied || status.isPermanentlyDenied) {
      bool isShown = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('권한 요청'),
            content: Text('이미지를 선택하기 위해서는 갤러리 접근 권한이 필요합니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () async {
                  // 앱 설정으로 이동하여 권한 설정 가능
                  bool openedSettings = await openAppSettings();
                  Navigator.of(context).pop(openedSettings);
                },
                child: const Text('설정'),
              ),
            ],
          );
        },
      );

      if (isShown == true) {
        status = await Permission.photos.request();
      }
    }

    return status;
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

  static Future<bool> checkCameraPermission(BuildContext context, bool mounted) async {
    // 현재 카메라 권한 상태 확인
    final permissionStatus = await Permission.camera.status;

    print('카메라 권한 상태 : $permissionStatus');

    // 권한이 부여된 경우 true 반환
    if (permissionStatus.isGranted) {
      print('카메라 권한 허용됨');
      return true;
    }

    // 권한이 거부된 경우 다이얼로그 띄우고 설정으로 이동
    if (permissionStatus.isDenied) {
      // 사용자가 권한을 거부한 경우
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('카메라 권한 필요'),
          content: const Text('사진 촬영을 위해 카메라 권한이 필요합니다.\n설정에서 권한을 허용해주세요.'),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('설정으로 이동'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return false;
    }
    // 예외 상황 (권한 상태 확인 불가능)
    return false;
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
