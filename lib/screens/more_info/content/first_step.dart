import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/more_info/components/gender_card.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/shared/text_field.dart';
import 'package:sonar/styles/colors.dart' as colors;

class FirstStep extends StatefulWidget {
  const FirstStep(
      {Key? key,
      required this.formKey,
      required this.ageController,
      required this.cityController,
      required this.titleController})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController ageController;
  final TextEditingController titleController;
  final TextEditingController cityController;
  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  bool isManSelected = false;
  bool isWomenSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<PersonalInfo>(builder: (context, personalInfo, child) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 14),
                child: Text(
                  "Fill the information",
                  style: TextStyle(fontSize: 18, color: colors.secondTextColor),
                ),
              ),
              MainTextField(controller: widget.ageController, hint: "Age"),
              MainTextField(controller: widget.titleController, hint: "Title"),
              MainTextField(controller: widget.cityController, hint: "City"),
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
                      personalInfo.choseGender(isMale: true);
                      personalInfo.isGenderNull(false);
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
                      personalInfo.choseGender(isMale: false);
                      personalInfo.isGenderNull(false);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
