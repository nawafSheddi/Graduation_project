import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sonar/styles/colors.dart' as colors;

class MoreButton extends StatefulWidget {
  const MoreButton({
    Key? key,
    required this.name,
    required this.offer,
    required this.code,
    required this.trackingProvider,
    required this.personalInfo,
    required this.offerID,
    required this.category,
    required this.offerLink,
  }) : super(key: key);

  final String name;
  final String offer;
  final String code;
  final String category;
  final String offerID;
  final String offerLink;

  final TrackingProvider trackingProvider;
  final PersonalInfo personalInfo;

  @override
  State<MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  bool upClicked = false;
  bool downClicked = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                upClicked = !upClicked;
              });
            },
            child: Icon(
              upClicked ? Icons.thumb_up_rounded : Icons.thumb_up_off_alt_outlined,
              color: upClicked ? colors.thirdColor : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final Uri _url = Uri.parse(widget.offerLink);
              if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
              }
              widget.trackingProvider.addAction(
                  action: UserAction.seeMore,
                  userId: widget.personalInfo.userID,
                  category: widget.category,
                  offerID: widget.offerID);
            },
            child: const Text(
              "More",
              style: TextStyle(fontSize: 18, color: Color(0xff221AFB), fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                downClicked = !downClicked;
              });
              FirebaseFirestore.instance
                  .collection("report")
                  .doc(widget.offerID)
                  .collection(widget.personalInfo.userID)
                  .add({"name": widget.name, "offer": widget.offer, "category": widget.category, "code": widget.code});
            },
            child: Icon(
              downClicked ? Icons.thumb_down_rounded : Icons.thumb_down_alt_outlined,
              color: downClicked ? colors.thirdColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
