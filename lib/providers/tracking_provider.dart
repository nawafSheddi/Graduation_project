import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class TrackingProvider with ChangeNotifier {
  final Box _db = Hive.box('appDB');

  List actionList = [];

  DateTime startTimer = DateTime(0);
  Map trackedOffer = {};

  String sessionId = "";
  DateTime whenSessionStart = DateTime.now();
  int sessionEvent = 0;
  Map eachCategoryPercentage = {};

  List<String> categories = ["food", "travel", "entertainment", "clothe"];

  loadActionList(String userID) {
    dynamic data = null;

    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(_db.get("userInfo")["userID"])
          .collection("Actions")
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((action) {
                  Map newAction = action.data();
                  newAction["date"] = action.data()["date"].toDate();

                  actionList.add(newAction);
                })
              });
    } catch (e) {
      print(e.toString());
      print("no actions");
      data = _db.get("actionList");
    }

    if (data != null) {
      actionList = data;
    }
  }

  addAction({required UserAction action, required String userId, required String? category, required String? offerID}) {
    Map<String, dynamic> actionData = {
      "userId": userId,
      "sessionId": sessionId,
      "sessionEvent": sessionEvent + 1,
      "action": "$action",
      "category": category,
      "offerID": offerID.toString(),
      "date": DateTime.now(),
    };

    try {
      FirebaseFirestore.instance.collection("Users").doc(userId).collection("Actions").add(actionData);
    } catch (e) {
      print(e.toString());
      print("cant add action");
    }

    actionList.add(actionData);
    _db.put("actionList", actionList);

    sessionEvent++;
    stopSession();
  }

  startSession() {
    sessionId = "${Random().nextInt(9999999) + Random().nextInt(99999)}";
    whenSessionStart = DateTime.now();
    sessionEvent = 0;
  }

  stopSession() {
    if (DateTime.now().subtract(const Duration(minutes: 30)) == whenSessionStart) {
      startSession();
    }
  }

  startTrackDurationInOffer({required String userId, required String category, required String offerID}) {
    if (startTimer.year == 0) {
      startTimer = DateTime.now();
      trackedOffer = {"userId": userId, "category": category, "offerID": offerID};
    }
  }

  stopTrackDurationInOffer() {
    if (startTimer.year != 0) {
      if (getHowManySeconds(startTimer, DateTime.now()) > 12) {
        addAction(
            action: UserAction.durationInOffer,
            userId: trackedOffer["userId"],
            category: trackedOffer["category"],
            offerID: trackedOffer["offerID"]);
      }
    }
    startTimer = DateTime(0);
  }

  int getHowManySeconds(DateTime startTime, DateTime endTime) {
    int min = endTime.minute - startTime.minute;
    int sec = endTime.second - startTimer.second;

    int totalTime = (min * 60) + sec;
    return totalTime;
  }

  // ################################### Dangerous hard work ##################################

  makeMiracle() {
    Map<String, List<Map>> splitedActionsByCategory = splitByCategory();
    print(1);
    Map actionsGroupedByCategory = groupByDate(splitedActionsByCategory);
    print(2);

    Map historyMatrix = countActions(actionsGroupedByCategory);
    print(3);

    Map categoriesAgingFactor = agingFactor(historyMatrix);
    print(4);

    eachCategoryPercentage = standardization(categoriesAgingFactor);
    print(5);
    notifyListeners();
  }

  Map<String, List<Map>> splitByCategory() {
    Map<String, List<Map>> splitedByCategory = {
      "food": [],
      "travel": [],
      "entertainment": [],
      "clothe": [],
    };

    categories.forEach((category) {
      actionList.forEach((action) {
        if (action["action"] != "UserAction.appOpened") {
          // print(action);
          if (action["category"].toLowerCase() == category) {
            splitedByCategory[category]!.add(action);
          }
        }
      });
    });

    return splitedByCategory;
  }

  formatDates(List<Map<dynamic, dynamic>> list) {
    list.forEach((element) {
      element["date"] = DateTime.parse(DateFormat('yyyy-MM-dd').format(element["date"]));
    });

    return list;
  }

  groupByDate(Map<String, List<Map>> actionsByCategory) {
    Map groupedByCategory = {
      "food": [],
      "travel": [],
      "entertainment": [],
      "clothe": [],
    };

    // print(actionsByCategory);
    // print("#################");
    categories.forEach((category) {
      groupedByCategory[category] =
          groupBy(formatDates(actionsByCategory[category]!), (Map obj) => DateFormat('yyyy-MM-dd').format(obj['date']));
    });

    return groupedByCategory;
  }

  // countActions(Map<String, Map<String, List>> actions) {
  Map countActions(Map actions) {
    Map temp = {};
    Map newMap = rebuildMap(actions);
    categories.forEach((category) {
      actions[category]!.keys.toList().forEach((date) {
        actions[category]![date]!.forEach(
          (action) {
            try {
              temp[action["action"]] = temp[action["action"]] + 1;
            } catch (e) {
              temp[action["action"]] = 1;
            }
          },
        );

        newMap[category]![date] = multiplyWithFactors(temp);

        temp = {};
      });
    });
    return newMap;
  }

  rebuildMap(Map oldMap) {
    Map newMap = {};

    oldMap.keys.toList().forEach((category) {
      newMap[category] = {};
    });

    categories.forEach((category) {
      oldMap[category]!.keys.toList().forEach((date) {
        newMap[category][date] = 0;
      });
    });
    return newMap;
  }

  // agingFactor(Map<String, Map<String, double>> hMatrix) {
  Map agingFactor(Map hMatrix) {
    Map categoriesAgingFactor = {};

    // print(hMatrix);
    categories.forEach((category) {
      try {
        categoriesAgingFactor[category] = (daysBetween(DateTime.parse(hMatrix[category]!.keys.toList().last)) -
                daysBetween(DateTime.parse(hMatrix[category]!.keys.toList().first))) *
            0.8;
      } catch (e) {}
    });

    return categoriesAgingFactor;
  }

  standardization(Map categoriesFactor) {
    print(categoriesFactor);
    double summation = 0.0;
    Map categoriesPercentage = {};
    categories.forEach((category) {
      try {
        summation += categoriesFactor[category];
      } catch (e) {}
    });

    categories.forEach((category) {
      try {
        categoriesPercentage[category] = (double.parse("${categoriesFactor[category]}") / summation) * 100;
      } catch (e) {}
    });

    return categoriesPercentage;
  }

  double multiplyWithFactors(Map actionFrequency) {
    double totalPintsForDay = 0;
    actionFrequency.keys.toList().forEach((action) {
      switch (action) {
        case "UserAction.useCodeButton":
          totalPintsForDay += actionFrequency[action] * 0.30;
          break;
        case "UserAction.like":
          totalPintsForDay += actionFrequency[action] * 0.20;
          break;
        case "UserAction.offerOpened":
          totalPintsForDay += actionFrequency[action] * 0.09;
          break;
        case "UserAction.bannerClicked":
          totalPintsForDay += actionFrequency[action] * 0.08;
          break;
        case "UserAction.filterUsed":
          totalPintsForDay += actionFrequency[action] * 0.07;
          break;
        case "UserAction.durationInOffer":
          totalPintsForDay += actionFrequency[action] * 0.06;
          break;
        case "UserAction.endHomeList":
          totalPintsForDay += actionFrequency[action] * 0.05;
          break;
        case "UserAction.likeUsed":
          totalPintsForDay += actionFrequency[action] * 0.02;
          break;
        case "UserAction.likedOpened":
          totalPintsForDay += actionFrequency[action] * 0.15;
          break;
        case "UserAction.share":
          totalPintsForDay += actionFrequency[action] * 0.04;
          break;
        case "UserAction.seeMore":
          totalPintsForDay += actionFrequency[action] * 0.06;
          break;
        case "UserAction.swipedImage":
          totalPintsForDay += actionFrequency[action] * 0.03;
          break;
        default:
      }
    });

    return totalPintsForDay;
  }

  int daysBetween(DateTime from) {
    DateTime now = DateTime.now();
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime(now.year, now.month, now.day);
    return (to.difference(from).inHours / 24).round();
  }
}

enum UserAction {
  useCodeButton,
  like,
  offerOpened,
  bannerClicked,
  filterUsed,
  durationInOffer,
  endHomeList,
  likeUsed,
  likedOpened,
  share,
  appOpened,
  seeMore,
  swipedImage,
}
