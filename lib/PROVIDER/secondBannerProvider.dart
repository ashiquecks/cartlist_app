import 'package:cartlist/MODAL/secondBannerModal.dart';
import 'package:flutter/material.dart';

class SecondBannerProvider extends ChangeNotifier {
  List<SecondBannerModal> _bannerList = [];

  List<SecondBannerModal> get postList => _bannerList;

  setPostList(List<SecondBannerModal> list) {
    _bannerList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<SecondBannerModal> list) {
    _bannerList = list;
    notifyListeners();
  }

  SecondBannerModal getPostByIndex(int index) => _bannerList[index];
}
