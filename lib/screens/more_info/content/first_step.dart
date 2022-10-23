import 'package:flutter/material.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/screens/more_info/components/gender_card.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/shared/text_field.dart';
import 'package:sonar/styles/colors.dart' as colors;

class FirstStep extends StatefulWidget {
  const FirstStep({Key? key}) : super(key: key);

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool isManSelected = false;
  bool isWomenSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 14),
          child: Text(
            "Fill the information",
            style: TextStyle(fontSize: 18, color: colors.secondTextColor),
          ),
        ),
        MainTextField(controller: ageController, hint: "Age"),
        MainTextField(controller: titleController, hint: "Title (optional)"),
        MainTextField(controller: cityController, hint: "City"),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text(
            "What is your gender ?",
            style: TextStyle(fontSize: 21, color: Colors.black),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GenderCard(
              isMale: true,
              isSelected: isManSelected,
              onTap: () {
                setState(() {
                  isManSelected = true;
                  isWomenSelected = false;
                });
              },
            ),
            GenderCard(
              isMale: false,
              isSelected: isWomenSelected,
              onTap: () {
                setState(() {
                  isManSelected = false;
                  isWomenSelected = true;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
