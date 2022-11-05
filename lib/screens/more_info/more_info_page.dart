import 'package:flutter/material.dart';
import 'package:progresso/progresso.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/home/home_page.dart';
import 'package:sonar/screens/more_info/components/steps_counter.dart';
import 'package:sonar/screens/more_info/content/first_step.dart';
import 'package:sonar/screens/more_info/content/second_step.dart';
import 'package:sonar/screens/more_info/content/third_step.dart';
import 'package:sonar/shared/main_button.dart';
import 'package:sonar/styles/colors.dart' as colors;

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);
  static const routeName = '/More-info';

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  final GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();

  bool isManSelected = false;
  bool isWomenSelected = false;

  int currentStep = 1;

  bool isNull = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PersonalInfo>(builder: (context, personalInfo, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Personal information",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              StepsCounter(step: currentStep),
              Progresso(
                progress: 0.3333333 * currentStep,
                progressColor: colors.thirdColor,
                backgroundColor: const Color(0xffE5E7EB),
                progressStrokeCap: StrokeCap.round,
                backgroundStrokeCap: StrokeCap.round,
                progressStrokeWidth: 5,
              ),
              const SizedBox(height: 4),
              currentStep == 1
                  ? FirstStep(formKey: firstFormKey)
                  : currentStep == 2
                      ? const SecondStep()
                      : currentStep == 3
                          ? const ThirdStep()
                          : const SizedBox(),
            ],
          ),
        ),
        bottomNavigationBar: MainButton(
          padding: EdgeInsets.only(bottom: size.height * 0.035, left: size.width * 0.05, right: size.width * 0.05),
          onPressed: () {
            checkNullField(personalInfo);
          },
          title: "Next",
          isDangerous: false,
        ),
      );
    });
  }

  checkNullField(PersonalInfo personalInfo) async {
    switch (currentStep) {
      case 1:
        if (firstFormKey.currentState!.validate() && personalInfo.isMale != null) {
          setState(() {
            currentStep++;
          });
        } else {
          if (personalInfo.isMale == null) {
            personalInfo.isGenderNull(true);
          }
        }
        break;
      case 2:
        if (personalInfo.educational != "" && personalInfo.employmentState != "") {
          setState(() {
            currentStep++;
          });
        } else {
          if (personalInfo.educational == "" && personalInfo.employmentState == "") {
            personalInfo.secondStepChoicesNull(true, true);
          } else if (personalInfo.educational == "") {
            personalInfo.secondStepChoicesNull(true, false);
          } else {
            personalInfo.secondStepChoicesNull(false, true);
          }
        }

        break;
      case 3:
        await personalInfo.saveUserInfo();
        Navigator.pushNamed(context, HomePage.routeName);
        break;
      default:
    }
  }
}
