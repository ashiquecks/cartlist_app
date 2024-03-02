import 'package:cartlist/MODAL/favCategoryModal.dart';
import 'package:flutter/cupertino.dart';

class FavCategoryNameProvider with ChangeNotifier {
  String? selectedFavItem;

  String? selectedFavID;

  changeSelectFavItem(String passSelectFavItem) {
    selectedFavItem = passSelectFavItem;
    notifyListeners();
  }

  changeSelectFavID(String passSelectFavID) {
    selectedFavID = passSelectFavID;
    notifyListeners();
  }

  bool listIsEmpty = false;

  changeListStatus(bool statusValue) {
    listIsEmpty = statusValue;
    notifyListeners();
  }

  List<FavCategoryNameModal> _nameList = [];

  List<FavCategoryNameModal> get postList => _nameList;

  setPostList(List<FavCategoryNameModal> list) {
    _nameList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<FavCategoryNameModal> list) {
    _nameList = list;
    notifyListeners();
  }

  FavCategoryNameModal getPostByIndex(int index) => _nameList[index];
}
