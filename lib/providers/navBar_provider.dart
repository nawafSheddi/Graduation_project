import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sonar/screens/add_offer/add_offer.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/screens/likes_list/likes_screen.dart';
import 'package:sonar/screens/profile/profile_screen.dart';

class NavBarProvider with ChangeNotifier {
  int currentPage = 0;

  updateNavBar(int index, BuildContext context) {
    currentPage = index;
    switch (index) {
      case 0:
        navToPage(context, const HomePage());
        break;
      case 1:
        navToPage(context, const LikesScreen());
        break;
      case 2:
        navToPage(context, AddOffer());
        break;
      case 3:
        navToPage(context, const ProfileScreen());
        break;
      default:
    }
    notifyListeners();
  }

  navToPage(BuildContext context, page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
