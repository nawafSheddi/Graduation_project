import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/data/personal_information.dart' as prInfoData;
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/styles/colors.dart' as colors;

class SecondStep extends StatefulWidget {
  const SecondStep({Key? key}) : super(key: key);

  @override
  State<SecondStep> createState() => SecondStepState();
}

class SecondStepState extends State<SecondStep> {
  List<Widget> allWidget = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PersonalInfo>(
      builder: (context, personalInfo, child) {
        return Builder(
          builder: (context) {
            allWidget = [];
            getData(size, personalInfo);
            return SizedBox(
              height: size.height * 0.686,
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: allWidget,
              ),
            );
          },
        );
      },
    );
  }

  getData(Size size, PersonalInfo personalInfo) {
    prInfoData.personalInformation.forEach(
      (element) {
        List<Widget> choices = [];
        element["choices"].forEach(
          (choice) {
            choices.add(
              GestureDetector(
                onTap: () {
                  setState(() {
                    print("gg");
                    if (element["question"] == "Educational level") {
                      personalInfo.educational = choice;
                    } else if (element["question"] == "Employment State") {
                      personalInfo.employmentState = element["choices"];
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        color: element["question"] == "Educational level"
                            ? personalInfo.educational == element["choices"]
                                ? colors.thirdColor
                                : colors.cardsBorderColor
                            : element["question"] == "Employment State"
                                ? personalInfo.employmentState == element["choices"]
                                    ? colors.thirdColor
                                    : colors.cardsBorderColor
                                : colors.cardsBorderColor),
                  ),
                  child: Text(
                    choice,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          },
        );
        allWidget.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 14),
                child: Text(
                  element["question"],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: choices,
              )
            ],
          ),
        );
      },
    );
  }
}
