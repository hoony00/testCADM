
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DownloadImgNotifier extends StateNotifier<List<String>> {
  DownloadImgNotifier() : super([]);

  // 이미지 추가
  void insertImg(List<String> list) {
    state = list;
  }

  //서버로 부터 이미지 경로 받아오기
  Future<void> downloadImg() async {
    try {
      final response = await Dio().get(
          'https://fec9-61-98-7-200.ngrok-free.app/download');
      final List<String> imgList = [];
      for (var i = 0; i < 10; i++) {
        imgList.add(response.data[i]['url']);
      }
      state = imgList;
    } catch (e) {
      print(e);
    }
  }


}


final downloadImgProvider =
StateNotifierProvider<DownloadImgNotifier, List<String>>((ref) {
  return DownloadImgNotifier();
});
