import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sonar/data/offers.dart' as offersData;

class OffersProvider with ChangeNotifier {
  final Box _db = Hive.box('appDB');

  List offersList = [];
  int currentFilterIndex = 0;

  uploadAllOffers() async {
    try {
      await FirebaseFirestore.instance.collection("Offers").get().then((querySnapshot) => {
            querySnapshot.docs.forEach((doc) => {
                  offersList.add(doc.data()),
                })
          });
      _db.put("offers", offersList);
    } catch (e) {
      offersList = _db.get("offers");
    }
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

  buildListADsForYou({required Map percentage}) {
    List<String> categories = ["food", "travel", "entertainment", "clothe"];
    List allOffers = copyList(offersList);
    allOffers.shuffle();
    int counter = 0;
    List adsForYou = [];

    categories.forEach((category) {
      print(percentage[category].round());
      for (int i = 0; i < allOffers.length; i++) {
        if (allOffers[i]["category"] == category) {
          adsForYou.add(offersList[i]);
          counter++;
        }
        if (counter == percentage[category].round()) {
          break;
        }
      }
    });
    print(allOffers.length);
    print(adsForYou.length);
  }

  copyList(List oldList) {
    List newList = [];

    oldList.forEach((element) {
      newList.add(element);
    });
    return oldList;
  }

  getCategory(int index) {
    switch (index) {
      case 0:
        return "all";
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
