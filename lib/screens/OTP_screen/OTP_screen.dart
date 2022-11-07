import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/OTP_screen/components/OTP_pins.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/shared/main_button.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key, this.phoneNumber, this.otp}) : super(key: key);

  static const routeName = "/OTP-Page";

  String? phoneNumber = "568712266";
  String? otp;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool isLauding = false;
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PersonalInfo>(builder: (context, personalInfo, child) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const Text(
              "Enter the OTP",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            RichText(
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
              softWrap: true,
              maxLines: 1,
              textScaleFactor: 1,
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(
                    text: "the OTP have been sent ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: widget.phoneNumber!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.25),
              child: OTPPins(
                otp: widget.otp,
                pinController: pinController,
                personalInfo: personalInfo,
              ),
            ),
            MainButton(
                isDangerous: false,
                onPressed: () async {
                  setState(() {
                    isLauding = true;
                  });
                  if (widget.otp == pinController.text) {
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                  }
                  setState(() {
                    isLauding = false;
                  });
                },
                title: "Check")
          ],
        ),
      );
    });
  }
}
