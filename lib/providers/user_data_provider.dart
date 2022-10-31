import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDataProvider with ChangeNotifier {
  late Box<dynamic> _db;
  List<Map<String, dynamic>> likeList = [];

  UserDataProvider(Box<dynamic> db) {
    _db = db;
    var data = _db.get("likeList");
    if (data != null) {
      likeList = data;
    }
  }

  addLike({required String offerName, required String offerID}) {
    print("add to like");
    Map<String, dynamic> result = checkOfferIsLiked(offerID);
    if (result["isLiked"]) {
      likeList.remove(result["offer"]);
    } else {
      likeList.add({
        "offer_name": offerName,
        "offer_ID": offerID,
      });
    }
    notifyListeners();
  }

  Map<String, dynamic> checkOfferIsLiked(String offerID) {
    Map<String, dynamic> result = {"isLiked": false, "offer": null};

    likeList.forEach((offer) {
      if (offer["offer_ID"] == offerID) {
        result = {"isLiked": true, "offer": offer};
      }
    });
    return result;
  }
}
