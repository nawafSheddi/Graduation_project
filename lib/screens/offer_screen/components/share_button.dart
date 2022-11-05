import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/providers/tracking_provider.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    required this.name,
    required this.offer,
    required this.code,
    required this.trackingProvider,
    required this.personalInfo,
    required this.offerID,
    required this.category,
  }) : super(key: key);

  final String name;
  final String offer;
  final String code;
  final String category;
  final String offerID;
  final TrackingProvider trackingProvider;
  final PersonalInfo personalInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.06, right: size.width * 0.05),
        child: GestureDetector(
          onTap: () {
            Share.share('$name \n$offer\nUsing $code Code', subject: '$name offer from Sonar');
            trackingProvider.addAction(
                action: UserAction.share, userId: personalInfo.userID, category: category, offerID: offerID);
          },
          child: const Icon(
            Icons.ios_share_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
