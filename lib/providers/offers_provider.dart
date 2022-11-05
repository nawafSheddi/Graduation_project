import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sonar/data/offers.dart' as offersData;

class OffersProvider with ChangeNotifier {
  final Box _db = Hive.box('appDB');

  List offersList = [];
  int currentFilterIndex = 0;

  uploadAllOffers() {
    _db.put("offers", offersData.offers);
    offersList = offersData.offers;
  }

  getOfferByID(String id) {
    late Map result;
    offersList.forEach((offer) {
      if (offer["id"].toString() == id) {
        result = offer;
      }
    });
    return result;
  }

  filterOffersByCategory(int index) {
    offersList = offersData.offers;
    late List result = [];
    if (index != 0) {
      String category = getCategory(index);
      offersList.forEach((offer) {
        if (offer["category"].toString().toLowerCase() == category) {
          result.add(offer);
        }
      });
      offersList = result;
    }
    notifyListeners();
  }

  getCategory(int index) {
    switch (index) {
      case 1:
        return "food";
      case 2:
        return "clothe";
      case 3:
        return "entertainment";
      case 4:
        return "travel";
      default:
    }
  }

  addOffer(
      {required String name,
      required String description,
      required String offer,
      required String category,
      required String details,
      required String duration,
      required String links,
      required String image,
      required String code}) {
    offersList.add(
      {
        "id": DateTime.now().millisecond,
        "name": name,
        "Description": description,
        "offer": offer,
        "category": category,
        "details": details,
        "duration": duration,
        "links": links,
        "Image": image,
        "code": code,
      },
    );
  }
}
