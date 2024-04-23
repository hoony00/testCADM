
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../common/exception/exception.dart';
import '../../view/screen/add/s_check.dart';

class SelectedImgNotifier extends StateNotifier<List<XFile>> {
  SelectedImgNotifier() : super([]);

  final String url = 'https://88c9-61-98-7-200.ngrok-free.app';

  // 이미지 추가
  void insertImg(List<XFile> list) {
    state = [...state, ...list];
  }

  // 카메라 이미지 추가
  void insertCameraImg(XFile file) {
    state = [...state, file];
  }

  // 이미지 삭제
  void removeImg(int idx) {
    if (idx >= 0 && idx < state.length) {
      state = List<XFile>.from(state)..removeAt(idx);
    }
  }

  // 전체 이미지 삭제
  void removeAll() {
    state = [];
  }

  // 확장자 제거
  String removeExtension(String path) {
    int lastDotIndex = path.lastIndexOf('.');
    if (lastDotIndex == -1) {
      return path;
    }
    String extensionStart = path.substring(0, lastDotIndex);
    int lastSlashIndex = extensionStart.lastIndexOf('/');
    if (lastSlashIndex != -1) {
      extensionStart = extensionStart.substring(lastSlashIndex + 1);
    }
    return path.substring(0, lastDotIndex - extensionStart.length);
  }

  // 이미지 업로드
  Future<void> upload() async {
    if (state.isEmpty) {
      debugPrint("이미지가 없습니다.");
      return;
    }

    debugPrint("========== 사진 업로드 시작 ==========");

    try {
      for (var i = 0; i < state.length; i++) {
        var imageType = state[i].path.split('.').last;
        //확장자 구별
        var compressedFile = await compressImage(state[i].path, imageType);

        if (compressedFile == null) {
          debugPrint("압축 파일이 null입니다.");
          return;
        }

        // 이미지 업로드 요청
        var response = await uploadImage(compressedFile, i, imageType);
        await handleResponse(response, "이미지 저장");

        if (response.statusCode == 200) {
          debugPrint("<--이미지 업로드 성공 OK! -->");
        }
      }
    } catch (e) {
      if (e is DioException) {
        await handleDioError(e);
      } else {
        debugPrint("알 수 없는 오류: $e");
      }
    }
  }

  // 이미지 업로드 요청
  Future<http.Response> uploadImage(XFile file, int index, String imageType) async {
    var uri = Uri.parse('$url/sales/images');
    var request = http.MultipartRequest('POST', uri);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      'images',
      stream,
      length,
      filename: 'saleIdx_$index.jpg', // 확장자를 .jpg로 변경
    );
    request.files.add(multipartFile);
    var response = await http.Response.fromStream(await request.send());
    return response;
  }

  // 이미지 압축
  Future<XFile?> compressImage(String path, String imageType) async {
    return await FlutterImageCompress.compressAndGetFile(
      format: imageType == 'png' ? CompressFormat.png : CompressFormat.jpeg,
      path,
      "${removeExtension(path)}_cmp.$imageType",
      quality: 80,
    );
  }

  // HTTP 응답 처리
  Future<void> handleResponse(http.Response response, String action) async {
    await ExceptionDio().handleHttpResponseCode(response.statusCode, action);
  }

  // Dio 오류 처리
  Future<void> handleDioError(DioException e) async {
    await ExceptionDio().handleDioError(e);
  }
}

final selectedImgProvider = StateNotifierProvider<SelectedImgNotifier, List<XFile>>((ref) {
  return SelectedImgNotifier();
});
