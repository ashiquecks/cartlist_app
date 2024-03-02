import 'package:cartlist/MODAL/stockProductModal.dart';
import 'package:flutter/cupertino.dart';

class StockProductProvider extends ChangeNotifier {
  bool listIsEmpty = false;

  changeListStatus(bool statusValue) {
    listIsEmpty = statusValue;
    notifyListeners();
  }

  List<StockProductModal> _stokList = [];

  List<StockProductModal> get postList => _stokList;

  setPostList(List<StockProductModal> list) {
    _stokList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<StockProductModal> list) {
    _stokList = list;
    notifyListeners();
  }

  StockProductModal getPostByIndex(int index) => _stokList[index];
}
