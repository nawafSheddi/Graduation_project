import 'package:flutter/material.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/shared/main_button.dart';

class OffersNavBar extends StatelessWidget {
  OffersNavBar({Key? key, required this.userDataProvider}) : super(key: key);

  final UserDataProvider userDataProvider;
  String offerID = "124423";

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
                  // TODO
                  print("liked");
                  userDataProvider.addLike(offerName: "jahez", offerID: offerID);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: userDataProvider.checkOfferIsLiked(offerID)["isLiked"] ? Colors.red : Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    userDataProvider.checkOfferIsLiked(offerID)["isLiked"]
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: userDataProvider.checkOfferIsLiked(offerID)["isLiked"] ? Colors.red : null,
                  ),
                ),
              ),
            ),
            MainButton(
              width: size.width * 0.7,
              onPressed: () {
                // TODO
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
