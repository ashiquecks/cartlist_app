import 'package:cartlist/MODAL/getCartModal.dart';
import 'package:flutter/cupertino.dart';

class GetCartProvider extends ChangeNotifier {
  bool listIsEmpty = false;

  changeListStatus(bool statusValue) {
    listIsEmpty = statusValue;
    notifyListeners();
  }

  List<GetCartModal> _carttList = [];

  List<GetCartModal> get postList => _carttList;

  setPostList(List<GetCartModal> list) {
    _carttList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<GetCartModal> list) {
    _carttList = list;
    notifyListeners();
  }

  GetCartModal getPostByIndex(int index) => _carttList[index];
}
