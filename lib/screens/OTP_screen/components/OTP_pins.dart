import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:sonar/styles/shadows.dart' as shadows;

import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/home/home_page.dart';

class OTPPins extends StatefulWidget {
  const OTPPins({
    Key? key,
    required this.otp,
    required this.pinController,
    required this.personalInfo,
  }) : super(key: key);
  final String? otp;
  final TextEditingController pinController;
  final PersonalInfo personalInfo;
  @override
  State<OTPPins> createState() => _OTPPinsState();
}

class _OTPPinsState extends State<OTPPins> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 234, 234),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      boxShadow: shadows.primaryShadow,
      borderRadius: BorderRadius.circular(8),
      color: Color.fromARGB(255, 248, 248, 248),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(border: Border.all(color: Colors.red)),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      validator: (s) {
        return s == widget.otp ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) async {
        if (pin == "2222") {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      },
    );
  }
}
