import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TrackingProvider with ChangeNotifier {
  final Box _db = Hive.box('appDB');

  List actionList = [];

  DateTime startTimer = DateTime(0);
  Map trackedOffer = {};

  loadActionList() {
    var data = _db.get("actionList");

    if (data != null) {
      actionList = data;
    }
  }

  addAction({required UserAction action, required String userId, required String? category, required String? offerID}) {
    Map actionData = {
      "userId": userId,
      "sessionId": null,
      "sessionEvent": null,
      "action": "$action",
      "category": category,
      "offerID": offerID.toString(),
      "date": DateTime.now(),
    };

    actionList.add(actionData);
    _db.put("actionList", actionList);
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
}

enum UserAction {
  useCodeButton, //
  like, //
  offerOpened, //
  bannerClicked, //
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
