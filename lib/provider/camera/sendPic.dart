import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/exception/exception.dart';
import '../../view/screen/add/s_add.dart';

class SelectedImgNotifier extends StateNotifier<List<XFile>> {
  SelectedImgNotifier() : super([]);

  // 이미지 추가
  void insertImg(List<XFile> list) {
    state = state + list;
  }

  void insertCameraImg(XFile file) {
    state = state + [file];
  }

  // 건당 삭제
  removeImg(int idx) {
    var temp = [...state];
    temp.removeAt(idx);
    state = temp;
  }

  // 전체삭제
  void removeAll() {
    state = [];
  }


  // 확장자 제거
  String removeExtension(String path) {
    int lastDotIndex = path.lastIndexOf('.');
    if (lastDotIndex == -1) {
      return path; // '.'이 없는 경우 전체 경로 반환
    }

    // '.' 이전 문자열 추출
    String extensionStart = path.substring(0, lastDotIndex);

    // '.' 이후 문자열 확인 (확장자만 추출)
    int lastSlashIndex = extensionStart.lastIndexOf('/');
    if (lastSlashIndex != -1) {
      extensionStart = extensionStart.substring(lastSlashIndex + 1);
    }

    // 확장자를 제외한 경로 반환
    return path.substring(0, lastDotIndex - extensionStart.length);
  }

  // 서버에 업로드
  void upload() async {
    if(state.isEmpty){
      print("이미지가 없습니다.");
      return;
    }
    debugPrint("==========사진 업로드 시작 =================");
    var dio = Dio();
    var formData = FormData();

    try{
      // 이미지를 FormData에 추가
      for (var i = 0; i < state.length; i++) {
        var imageType = state[i].path.split('.').last;
        var compressedFile = await FlutterImageCompress.compressAndGetFile(
          format: imageType == 'png' ? CompressFormat.png : CompressFormat.jpeg,
          state[i].path,
          "${removeExtension(state[i].path)}_cmp.${state[i].path.split('.').last}",
          quality: 80,
        );

        //null 체크
        if(compressedFile == null){
          debugPrint("압축 파일이 null입니다.");
          return;
        }

        // images 서버에서 받을 key값
        formData.files.add(MapEntry(
          "images",
          await MultipartFile.fromFile(
            compressedFile!.path,
            // uid+인덱스+확장자
            filename: 'saleIdx_$i.$imageType',
          ),
        ));

        // 4. 압축 후/전 파일 크기 출력
        var fileSizeInBytes = await File(compressedFile.path).length();
        var fileSizeInMB = fileSizeInBytes / (1024 * 1024); // 바이트를 메가바이트로 변환
        var fileSizeInBytes2 = await File(state[i].path).length();
        var fileSizeInMB2 = fileSizeInBytes2 / (1024 * 1024); // 바이트를 메가바이트로 변환
        debugPrint("압축 후 파일 사이즈 : ${fileSizeInMB.toStringAsFixed(2)} MB");
        debugPrint("압축 전 파일 사이즈 : ${fileSizeInMB2.toStringAsFixed(2)} MB");
      }
    }catch(e){
      debugPrint("압축 오류 : $e");
      return;
    }
      // 5. 업로드 진행 메시지 출력
      print("${state.length}개의 이미지가 업로드 됩니다. 잠시만 기다려주세요.......");

      try{
        // 6. S3 서버에 이미지 업로드 (POST 요청)
        var imagesResponse = await dio.post(
          'https://47c7-61-98-7-200.ngrok-free.app/sales/images',
          data: formData,

        );

        await ExceptionDio().handleHttpResponseCode(imagesResponse.statusCode!, "이미지 저장");

        if(imagesResponse.statusCode == 200){
          debugPrint("<--이미지 업로드 성공 OK! -->");

          // 8. 이미지 URL을 담을 리스트 생성
          List<String> imageURLs = [];
          // 이미지 업로드 후 응답받은 이미지 URL을 imageURLs에 저장
          for (var i = 0; i < imagesResponse.data.length; i++) {
            imageURLs.add(imagesResponse.data[i]);
          }
          debugPrint("일반 판매 게시물 업로드 중........ 잠시만 기다려주세요");

          // 9. 일반 판매 게시물 업로드 (POST 요청)
          var saleResponse = await dio.post(
            'https://47c7-61-98-7-200.ngrok-free.app/sales',
            data: {
              "price": 1000, // 가격
              "mark": false, // 인증 마크 여부
              "option": "abcd", // 옵션
              "product": {
                // 상품 정보
                "name": "1234", // 상품명
                "type": "레이저", // 상품 종류
                "year": 2024, // 제조년도
                "company": "abc", // 제조사
                "area": "서울" // 지역
              },
              "images": imageURLs, // 이미지 URL 리스트
            },
          );
          await ExceptionDio().handleHttpResponseCode(imagesResponse.statusCode!, "일반 판매 게시물 업로드");
        }
      }catch(e){

        await ExceptionDio().handleDioError(e as DioException);
      }

    }
  }


final selectedImgProvider =
    StateNotifierProvider<SelectedImgNotifier, List<XFile>>((ref) {
  return SelectedImgNotifier();
});
