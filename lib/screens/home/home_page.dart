import 'package:flutter/material.dart';
import 'package:sonar/screens/home/components/offer_card.dart';
import 'package:sonar/shared/slider.dart';
import 'package:sonar/shared/navBar.dart';
import 'package:sonar/styles/colors.dart' as colors;
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: colors.primaryColor,
        leading: GestureDetector(
          child: const Icon(Icons.search),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              child: const Icon(Icons.sort),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ImageSlider(),
            DefaultTabController(
              length: 4,
              child: TabBar(
                isScrollable: true,
                onTap: (int index) {
                  var hh = index == 0;
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                padding: const EdgeInsets.symmetric(vertical: 15),
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
                    "Food",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Cloth",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Fun",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: ListView(
                children: const [
                  OfferCard(image: "assets/images/brand/1.png", name: "Herfy", offer: "50%"),
                  OfferCard(image: "assets/images/brand/2.png", name: "Herfy", offer: "50%"),
                  OfferCard(image: "assets/images/brand/3.png", name: "Herfy", offer: "50%"),
                  OfferCard(image: "assets/images/brand/4.png", name: "Herfy", offer: "50%"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
