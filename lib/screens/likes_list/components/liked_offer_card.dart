import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/user_data_provider.dart';
import 'package:sonar/screens/offer_screen/offer_screen.dart';

class LikedOfferCard extends StatelessWidget {
  const LikedOfferCard({
    Key? key,
    required this.image,
    required this.name,
    required this.offer,
    required this.offerData,
  }) : super(key: key);

  final String name;
  final String offer;
  final String image;
  final Map? offerData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserDataProvider>(builder: (context, userDataProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.width * 0.015),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Slidable(
            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // TODO remove it from likes
                    userDataProvider.addLike(offerData: offerData);
                  },
                  flex: 3,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  spacing: 4,
                  label: 'Delete',
                  autoClose: true,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferScreen(
                      name: offerData!["name"],
                      offer: offerData!["offer"],
                      offerData: offerData,
                    ),
                  ),
                );
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.05),
                      child: FadeInImage.assetNetwork(
                        image: image,
                        placeholder: "assets/icons/price-tag.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            offer,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
