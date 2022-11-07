import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/screens/basic_data/basic_data_page.dart';
import 'package:sonar/screens/home/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  static const routeName = '/splash-screen';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final bool isLoggedIN = true;
  Box db = Hive.box('appDB');

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    Size size = MediaQuery.of(context).size;

    return Builder(
      builder: (context) {
        return Consumer4<OffersProvider, UserDataProvider, TrackingProvider, PersonalInfo>(
            builder: (context, offersProvider, userDataProvider, trackingProvider, personalInfo, child) {
          if (counter == 0) {
            setUp(
              offersProvider,
              userDataProvider,
              trackingProvider,
              personalInfo,
            );

            counter++;
          }
          return Center(
            child: AnimatedSplashScreen(
                duration: 3500,
                splashIconSize: size.width,
                backgroundColor: Colors.white,
                splash: Image.asset('assets/images/other/logo.png'),
                nextScreen: personalInfo.isLoggedIN ? const HomePage() : const BasicData(),
                splashTransition: SplashTransition.fadeTransition
                // pageTransitionType: PageTransitionType.scale,
                ),
          );
        });
      },
    );
  }

  setUp(
    offersProvider,
    userDataProvider,
    trackingProvider,
    personalInfo,
  ) async {
    await personalInfo.laudData();
    await offersProvider.uploadAllOffers();
    await userDataProvider.loadLikedList();
    await trackingProvider.startSession();
    await trackingProvider.loadActionList(personalInfo.userID);

    await trackingProvider.addAction(
      action: UserAction.appOpened,
      userId: personalInfo.userID,
      category: null,
      offerID: null,
    );
  }
}
