import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/OTP_screen/OTP_screen.dart';
import 'package:sonar/screens/basic_data/basic_data_page.dart';
import 'package:sonar/screens/basic_data/components/phpne_number_text_field.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/shared/text_field.dart';
import 'package:sonar/styles/colors.dart' as colors;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/SignIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Consumer<PersonalInfo>(
            builder: (context, personalInfo, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create a account",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Enter your phone number",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          PhoneNumberTextField(controller: phoneNumberController),
                        ],
                      ),
                    ),
                    MainButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (await personalInfo.checkIsRegister(phoneNumberController.text)) {
                            String otp = createOTP();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpPage(
                                  phoneNumber: phoneNumberController.text,
                                  otp: otp,
                                ),
                              ),
                            );
                          } else {
                            phoneNumberController.clear();
                            formKey.currentState!.validate();
                          }
                        }
                      },
                      title: "LogIn",
                      isDangerous: false,
                      padding: EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.38),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You already have an account?",
                            style: TextStyle(color: colors.secondTextColor, fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, BasicData.routeName);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(color: Color(0xff2FA2B9), fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String createOTP() {
    String otp = "";
    for (int i = 0; i < 4; i++) {
      String number = DateTime.now().millisecond.toString().substring(2);
      otp = otp + DateTime.now().millisecond.toString().substring(2);
      sleep(Duration(milliseconds: int.parse(number)));
    }

    return otp;
  }
}
