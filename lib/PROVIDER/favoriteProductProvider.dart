import 'package:cartlist/MODAL/favoriteProductModal.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProductProvider with ChangeNotifier {
  bool listIsEmpty = false;

  changeListStatus(bool statusValue) {
    listIsEmpty = statusValue;
    notifyListeners();
  }

  List<FavProductModal> _favtList = [];

  List<FavProductModal> get postList => _favtList;

  setPostList(List<FavProductModal> list) {
    _favtList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<FavProductModal> list) {
    _favtList = list;
    notifyListeners();
  }

  FavProductModal getPostByIndex(int index) => _favtList[index];
}
