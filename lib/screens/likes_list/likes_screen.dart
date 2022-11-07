import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/screens/likes_list/components/liked_offer_card.dart';
import 'package:sonar/shared/navBar.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);
  static const routeName = "/likes-screen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserDataProvider>(
      builder: (context, userDataProvider, child) {
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
              Builder(builder: (context) {
                List likedOffer = userDataProvider.likeList;
                List<Widget> allCards = [];
                likedOffer.forEach(
                  (offer) {
                    allCards.add(
                      LikedOfferCard(
                        image: offer["Image"],
                        name: offer["name"],
                        offer: offer["offer"],
                        offerData: offer,
                      ),
                    );
                  },
                );
                return SizedBox(
                  height: size.height * 0.81,
                  child: SingleChildScrollView(
                    child: Column(children: allCards),
                  ),
                );
              }),
            ],
          ),
          bottomNavigationBar: const NavBar(),
        );
      },
    );
  }
}
