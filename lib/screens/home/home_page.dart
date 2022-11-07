import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/offers_provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:sonar/screens/home/components/banner.dart';
import 'package:sonar/screens/home/components/home_page_tabs.dart';
import 'package:sonar/screens/home/components/offer_card.dart';
import 'package:sonar/shared/slider.dart';
import 'package:sonar/shared/navBar.dart';
import 'package:sonar/styles/colors.dart' as colors;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _mainScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer3<OffersProvider, TrackingProvider, PersonalInfo>(
      builder: (context, offersProvider, trackingProvider, personalInfo, child) {
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
                const HomePageBanner(),
                HomePageTabs(
                  offersProvider: offersProvider,
                  trackingProvider: trackingProvider,
                  personalInfo: personalInfo,
                ),
                Builder(builder: (context) {
                  List allOffers = offersProvider.offersList;
                  List<OfferCard> allCards = [];

                  allOffers.forEach(
                    (offer) {
                      allCards.add(
                        OfferCard(
                          image: offer["Image"],
                          name: offer["name"],
                          offer: "${offer["offer"]}",
                          offerData: offer,
                          trackingProvider: trackingProvider,
                          personalInfo: personalInfo,
                        ),
                      );
                    },
                  );
                  return SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: NotificationListener(
                      child: ListView(
                        controller: _mainScrollController,
                        children: allCards,
                      ),
                      onNotification: (t) {
                        if (t is ScrollEndNotification) {
                          if (_mainScrollController.position.atEdge) {
                            bool isTop = _mainScrollController.position.pixels == 0;
                            if (isTop) {
                              print('At the top');
                            } else {
                              print('At the bottom');
                              if (offersProvider.currentFilterIndex != 0) {
                                trackingProvider.addAction(
                                  action: UserAction.endHomeList,
                                  userId: personalInfo.userID,
                                  category: offersProvider.getCategory(offersProvider.currentFilterIndex),
                                  offerID: null,
                                );
                              }
                            }
                          }
                        }

                        return false;
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: const NavBar(),
        );
      },
    );
  }
}
