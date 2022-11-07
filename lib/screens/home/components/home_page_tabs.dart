import 'package:flutter/material.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomePageTabs extends StatelessWidget {
  const HomePageTabs({
    Key? key,
    required this.offersProvider,
    required this.trackingProvider,
    required this.personalInfo,
  }) : super(key: key);

  final OffersProvider offersProvider;
  final TrackingProvider trackingProvider;
  final PersonalInfo personalInfo;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: TabBar(
        isScrollable: true,
        onTap: (int index) {
          offersProvider.currentFilterIndex = index;
          if (index == 0) {
            trackingProvider.makeMiracle();
            offersProvider.buildListADsForYou(percentage: trackingProvider.eachCategoryPercentage);
          }
          offersProvider.filterOffersByCategory(index);
          trackingProvider.addAction(
              action: UserAction.filterUsed,
              userId: personalInfo.userID,
              category: offersProvider.getCategory(index),
              offerID: null);
        },
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        indicator: RectangularIndicator(
          bottomLeftRadius: 100,
          bottomRightRadius: 100,
          topLeftRadius: 100,
          topRightRadius: 100,
          strokeWidth: 2,
          // verticalPadding: 20,
          paintingStyle: PaintingStyle.stroke,
        ),
        tabs: const [
          Text(
            "All",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Food",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Clothe",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Entertainment",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Travel",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
