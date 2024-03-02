import 'package:cartlist/MODAL/mainBannerModal.dart';
import 'package:flutter/cupertino.dart';

class MainBannerProvider extends ChangeNotifier {
  List<MainBannerModal> _bannerList = [];

  List<MainBannerModal> get postList => _bannerList;

  setPostList(List<MainBannerModal> list) {
    _bannerList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<MainBannerModal> list) {
    _bannerList = list;
    notifyListeners();
  }

  MainBannerModal getPostByIndex(int index) => _bannerList[index];
}
