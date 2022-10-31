import 'package:flutter/material.dart';
import 'package:progresso/progresso.dart';
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
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            currentStep--;
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
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
            currentStep == 1
                ? const FirstStep()
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
          if (currentStep == 3) {
            Navigator.pushNamed(context, HomePage.routeName);
          } else {
            setState(() {
              currentStep++;
            });
          }
        },
        title: "Next",
        isDangerous: false,
      ),
    );
  }
}
