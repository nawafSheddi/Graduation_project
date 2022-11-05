import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDataProvider with ChangeNotifier {
  final Box _db = Hive.box('appDB');
  List likeList = [];

  loadLikedList() {
    var data = _db.get("likeList");

    if (data != null) {
      likeList = data;
    }
  }

  addLike({required Map? offerData}) {
    Map result = checkOfferIsLiked(offerData?["id"]);

    if (result["isLiked"]) {
      updateLikedList(isLiked: true, offer: result["offer"]);
    } else {
      updateLikedList(isLiked: false, offer: offerData);
    }
    notifyListeners();
  }

  Map checkOfferIsLiked(int offerID) {
    Map result = {"isLiked": false, "offer": null};

    likeList.forEach((offer) {
      if (offer["id"] == offerID) {
        result = {"isLiked": true, "offer": offer};
      }
    });
    return result;
  }

  updateLikedList({required bool isLiked, required Map? offer}) {
    if (isLiked) {
      likeList.remove(offer);
      _db.put("likeList", likeList);
    } else {
      likeList.add(offer!);
      _db.put("likeList", likeList);
    }
    notifyListeners();
  }
}
