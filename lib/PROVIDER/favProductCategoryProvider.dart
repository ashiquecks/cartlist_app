import 'package:cartlist/MODAL/favProductCategoryModal.dart';
import 'package:cartlist/MODAL/favoriteProductModal.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProductCategoryProvider with ChangeNotifier {
  bool listIsEmpty = false;

  changeListStatus(bool statusValue) {
    listIsEmpty = statusValue;
    notifyListeners();
  }

  List<FavProductCategoryModal> _favtCtProductList = [];

  List<FavProductCategoryModal> get postList => _favtCtProductList;

  setPostList(List<FavProductCategoryModal> list) {
    _favtCtProductList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<FavProductCategoryModal> list) {
    _favtCtProductList = list;
    notifyListeners();
  }

  FavProductCategoryModal getPostByIndex(int index) =>
      _favtCtProductList[index];
}
