import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/screens/offer_screen/offer_screen.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<TrackingProvider, PersonalInfo, OffersProvider>(
        builder: (context, trackingProvider, personalInfo, offersProvider, child) {
      return ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: Colors.white,
        indicatorBackgroundColor: Colors.grey,
        // onPageChanged: (value) {
        //   print('Page changed: $value');
        // },

        autoPlayInterval: 4000,
        isLoop: true,
        children: [
          GestureDetector(
            onTap: () {
              onClick(context, trackingProvider, personalInfo, offersProvider.getOfferByID("1"));
            },
            child: Image.asset(
              'assets/images/banner/1.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              onClick(context, trackingProvider, personalInfo, offersProvider.getOfferByID("6"));
            },
            child: Image.asset(
              'assets/images/banner/2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              onClick(context, trackingProvider, personalInfo, offersProvider.getOfferByID("3"));
            },
            child: Image.asset(
              'assets/images/banner/3.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });
  }

  onClick(context, TrackingProvider trackingProvider, PersonalInfo personalInfo, Map<String, dynamic>? offerData) {
    trackingProvider.addAction(
        action: UserAction.bannerClicked,
        userId: personalInfo.userID,
        category: offerData!["category"],
        offerID: offerData["id"].toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OfferScreen(
          name: offerData["name"],
          offer: offerData["offer"],
          offerData: offerData,
        ),
      ),
    );
  }
}
