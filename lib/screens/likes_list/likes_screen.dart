import 'package:flutter/material.dart';
import 'package:sonar/screens/likes_list/components/liked_offer_card.dart';
import 'package:sonar/shared/navBar.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);
  static const routeName = "/likes-screen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.09,
            padding: EdgeInsets.only(bottom: size.height * 0.005),
            // decoration: BoxDecoration(),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_rounded, color: Colors.red),
                  SizedBox(width: 5),
                  Text(
                    "Likes",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: const [
                LikedOfferCard(image: "assets/images/brand/1.png", name: "Herfy", offer: "50%"),
                LikedOfferCard(image: "assets/images/brand/2.png", name: "Herfy", offer: "50%"),
                LikedOfferCard(image: "assets/images/brand/3.png", name: "Herfy", offer: "50%"),
                LikedOfferCard(image: "assets/images/brand/4.png", name: "Herfy", offer: "50%"),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
