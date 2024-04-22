import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class TempSelectedImgNotifier extends StateNotifier<List<XFile>> {
  TempSelectedImgNotifier() : super([]);

  // 이미지 추가
  void insertImg(List<XFile> list) {
    state = list;
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


}

final tempSelectedImgProvider =
    StateNotifierProvider<TempSelectedImgNotifier, List<XFile>>((ref) {
  return TempSelectedImgNotifier();
});
