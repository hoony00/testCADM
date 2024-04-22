import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ExceptionDio{

// Dio 에러 처리 함수
  Future<void> handleDioError(DioException e) async {
    debugPrint(" <<<<<<<<<<<<<<<글로벌 익셉션 실행>>>>>>>>>>>>>>>> ");
    switch (e.type) {
      case DioExceptionType.badResponse:
        debugPrint("잘못된 요청: ${e.message}");
        break;
      case DioExceptionType.badCertificate:
        debugPrint("잘못된 인증서: ${e.message}");
        break;
      case DioExceptionType.sendTimeout:
        debugPrint("요청 시간 초과: ${e.message}");
        break;
      case DioExceptionType.receiveTimeout:
        debugPrint("receiveTimeout : ${e.message}");
        break;
      case DioExceptionType.connectionError:
        debugPrint("연결 오류: ${e.message}");
        break;
      case DioExceptionType.connectionTimeout:
        debugPrint("connectionTimeout: ${e.message}");
        break;
      case DioExceptionType.cancel:
        debugPrint("요청 취소: ${e.message}");
        break;
      case DioExceptionType.unknown:
        debugPrint("알 수 없는 오류: ${e.message}");
        break;
    }
  }

// HTTP 응답 코드 처리 함수
  Future<void> handleHttpResponseCode(int statusCode, String apiName) async {
    switch (statusCode) {
      case 200:
        print("$apiName <--성공!-->");
        break;
      case 400:
        print("$apiName 400 요청 오류 : $statusCode");

        print("$apiName 요청 오류: $statusCode");
        break;
      case 401:
        print("$apiName 인증 실패: $statusCode");
        break;
      case 500:
        print("$apiName 서버 오류: $statusCode");
        break;
      default:
        print("$apiName 알 수 없는 오류: $statusCode");
    }
  }

}