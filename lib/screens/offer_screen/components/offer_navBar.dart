import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/shared/main_button.dart';

class OffersNavBar extends StatelessWidget {
  const OffersNavBar({
    Key? key,
    required this.userDataProvider,
    required this.offerData,
    required this.trackingProvider,
    required this.personalInfo,
  }) : super(key: key);

  final UserDataProvider userDataProvider;
  final TrackingProvider trackingProvider;
  final PersonalInfo personalInfo;
  final Map? offerData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, -2.5),
              blurRadius: 10.0,
              spreadRadius: -7.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              child: GestureDetector(
                onTap: () {
                  userDataProvider.addLike(offerData: offerData);
                  trackingProvider.addAction(
                      action: UserAction.like,
                      userId: personalInfo.userID,
                      category: offerData!["category"],
                      offerID: offerData!["id"].toString());
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: userDataProvider.checkOfferIsLiked(offerData?["id"])["isLiked"]
                            ? Colors.red
                            : Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    userDataProvider.checkOfferIsLiked(offerData?["id"])["isLiked"]
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: userDataProvider.checkOfferIsLiked(offerData?["id"])["isLiked"] ? Colors.red : null,
                  ),
                ),
              ),
            ),
            MainButton(
              width: size.width * 0.7,
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: offerData!["code"]));
                trackingProvider.addAction(
                    action: UserAction.useCodeButton,
                    userId: personalInfo.userID,
                    category: offerData!["category"],
                    offerID: offerData!["id"].toString());
              },
              title: "Use the offer",
              isDangerous: false,
            ),
          ],
        ),
      ),
    );
  }
}
