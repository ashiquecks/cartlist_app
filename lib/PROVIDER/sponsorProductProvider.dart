import 'package:cartlist/MODAL/sponserdProductModal.dart';
import 'package:flutter/cupertino.dart';

class SponsorProductProvider extends ChangeNotifier {
  List<SponsordProductModal> _sponsorList = [];

  List<SponsordProductModal> get postList => _sponsorList;

  setPostList(List<SponsordProductModal> list) {
    _sponsorList.addAll(list);
    notifyListeners();
  }

  mergePostList(List<SponsordProductModal> list) {
    _sponsorList = list;
    notifyListeners();
  }

  SponsordProductModal getPostByIndex(int index) => _sponsorList[index];
}
