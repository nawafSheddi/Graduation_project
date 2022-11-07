import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/screens/offer_screen/components/features_row.dart';
import 'package:sonar/screens/offer_screen/components/more_button.dart';
import 'package:sonar/screens/offer_screen/components/offer_navBar.dart';
import 'package:sonar/screens/offer_screen/components/share_button.dart';
import 'package:sonar/screens/offer_screen/components/space.dart';
import 'package:sonar/shared/back_button.dart';
import 'package:sonar/shared/slider.dart';
import 'package:sonar/styles/colors.dart' as colors;

class OfferScreen extends StatefulWidget {
  const OfferScreen({
    Key? key,
    this.name,
    this.offer,
    this.offerData,
  }) : super(key: key);
  static const routeName = "/offer-screen";

  final String? name;
  final String? offer;

  final Map? offerData;

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHight = size.height * 0.5199;
    if (widget.offerData?["details"]!.length > 30) {
      cardHight += 25.5;
    }
    if (widget.offer!.length > 70) {
      cardHight += 30;
    }
    return Consumer3<UserDataProvider, TrackingProvider, PersonalInfo>(
      builder: (context, userDataProvider, trackingProvider, personalInfo, child) {
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
                        height: cardHight,
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
                            Text(
                              widget.offerData?["category"] ?? "Restaurant",
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                              textDirection: TextDirection.ltr,
                            ),
                            const Space(),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.offerData?["name"],
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    color: colors.thirdColor),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.offer ?? "Offer",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const Space(),
                                Text(
                                  widget.offerData?["details"] ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Space(height: 25),
                                const Divider(thickness: 1),
                                const Space(),
                                MoreButton(
                                  name: widget.offerData?["name"],
                                  offer: widget.offerData?["details"],
                                  code: widget.offerData?["code"],
                                  trackingProvider: trackingProvider,
                                  personalInfo: personalInfo,
                                  offerID: widget.offerData!["id"].toString(),
                                  category: widget.offerData?["category"],
                                  offerLink: widget.offerData?["links"],
                                ),
                              ],
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
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text("Features", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            FeaturesRow(name: widget.offerData!["duration"]),
                            const FeaturesRow(name: "Can use it more than ones"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
              ),
              OffersNavBar(
                  userDataProvider: userDataProvider,
                  offerData: widget.offerData,
                  trackingProvider: trackingProvider,
                  personalInfo: personalInfo),
              MainBackButton(
                onPressed: () {
                  trackingProvider.stopTrackDurationInOffer();
                  Navigator.pop(context);
                },
              ),
              ShareButton(
                  name: widget.offerData!["name"],
                  offer: widget.offerData!["details"],
                  code: widget.offerData!["code"],
                  trackingProvider: trackingProvider,
                  personalInfo: personalInfo,
                  offerID: widget.offerData!["id"].toString(),
                  category: widget.offerData!["category"])
            ],
          ),
        );
      },
    );
  }
}
