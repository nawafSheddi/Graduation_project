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
  }) : super(key: key);

  final String name;
  final String offer;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserDataProvider>(builder: (context, userDataProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.width * 0.015),
        child: Slidable(
          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  // TODO remove it from likes
                  userDataProvider.addLike(offerName: "jahez", offerID: "135143");
                },
                flex: 3,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                spacing: 4,
                label: 'Delete',
                autoClose: true,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () async {
              // String brandName = "Careem";

              // final response = await http.get(
              //   Uri.parse(
              //       'https://www.google.com/search?q=$brandName&client=safari&rls=en&sxsrf=ALiCzsbc7jVPGpW9wKDlqH_wEziyH2DT3g:1665687911785&tbm=isch&source=iu&ictx=1&vet=1&fir=OOHUXMn-_e_ZrM%252Cm5dQVUxQl58RDM%252C%252Fg%252F11cmqkl_vh&usg=AI4_-kQHuR35Bk0o4rTym9E4_2sPczQL-w&sa=X&ved=2ahUKEwiijaeC8936AhWhhP0HHQWnBPgQ_B16BAhlEAI#imgrc=OOHUXMn-_e_ZrM'),
              // );
              // var document = parse(response.body);

              // final elements = await document.querySelectorAll('.png');

              // print(elements.map((a) => a.querySelector('img')!.attributes['src']).toList());
              Navigator.pushNamed(context, OfferScreen.routeName);
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
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        offer,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
