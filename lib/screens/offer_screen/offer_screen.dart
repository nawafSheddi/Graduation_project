import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/screens/offer_screen/components/features_row.dart';
import 'package:sonar/screens/offer_screen/components/offer_navBar.dart';
import 'package:sonar/screens/offer_screen/components/space.dart';
import 'package:sonar/shared/back_button.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/shared/slider.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);
  static const routeName = "/offer-screen";

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserDataProvider>(
      builder: (context, userDataProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(75),
                  bottomRight: Radius.circular(75),
                ),
                child: Image.asset("assets/images/other/delivery.png"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height,
                  child: ListView(
                    padding: EdgeInsets.only(top: size.height * 0.25),
                    children: [
                      Container(
                        height: size.height * 0.5199,
                        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        padding: EdgeInsets.all(size.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 5.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Restaurant", style: TextStyle(fontSize: 17)),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Jahez",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 3.5, color: Colors.red),
                              ),
                            ),
                            const Divider(thickness: 1),
                            const Space(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: const ImageSlider(),
                            ),
                            const Space(
                              height: 25,
                            ),
                            const Text(
                              "Free Delivery Jahez",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Space(),
                            const Text(
                              "You can get free delivery and you can get all the services and terms you want",
                              style: TextStyle(fontSize: 16),
                            ),
                            const Space(height: 25),
                            const Divider(thickness: 1),
                            const Space(),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Read More",
                                style: TextStyle(fontSize: 18, color: Color(0xff221AFB), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.1799, // the length will be multiply by the number of features
                        width: size.width * 0.9,
                        margin: EdgeInsets.all(size.width * 0.05),
                        padding: EdgeInsets.all(size.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 2.5),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text("Features", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            FeaturesRow(name: "Free delivery"),
                            FeaturesRow(name: "Can use it more than ones"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
              ),
              OffersNavBar(userDataProvider: userDataProvider),
              const MainBackButton(),
            ],
          ),
        );
      },
    );
  }
}
