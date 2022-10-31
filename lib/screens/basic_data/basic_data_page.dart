import 'package:flutter/material.dart';
import 'package:sonar/screens/basic_data/components/phpne_number_text_field.dart';
import 'package:sonar/shared/text_field.dart';
import 'package:sonar/screens/more_info/more_info_page.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/styles/colors.dart' as colors;

class BasicData extends StatefulWidget {
  const BasicData({Key? key}) : super(key: key);
  static const routeName = "/basic-data";

  @override
  State<BasicData> createState() => _BasicDataState();
}

class _BasicDataState extends State<BasicData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Create a account",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Create an account to continue",
              style: TextStyle(color: colors.secondTextColor, fontSize: 17),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    MainTextField(controller: nameController, hint: "Full Name"),
                    MainTextField(controller: emailController, hint: "Email"),
                    PhoneNumberTextField(controller: phoneNumberController),
                  ],
                ),
              ),
            ),
            MainButton(
              onPressed: () {
                Navigator.pushNamed(context, MoreInfo.routeName);
              },
              title: "Sign Up",
              isDangerous: false,
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You already have an account?",
                    style: TextStyle(color: colors.secondTextColor, fontSize: 17),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Sign Up");
                    },
                    child: const Text(
                      " Sign In",
                      style: TextStyle(color: Color(0xff2FA2B9), fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
