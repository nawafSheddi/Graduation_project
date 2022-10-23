import 'package:flutter/material.dart';
import 'package:sonar/styles/colors.dart' as colors;

class ThirdStep extends StatefulWidget {
  const ThirdStep({Key? key}) : super(key: key);

  @override
  State<ThirdStep> createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  int selectedBrand = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 14),
          child: Text(
            "choose your favorite companies !",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Builder(
          builder: (context) {
            List<Widget> allBrands = cardGenerator(size);

            return SizedBox(
              height: size.height * 0.61306,
              child: GridView.count(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                crossAxisSpacing: size.width * 0.05,
                mainAxisSpacing: size.width * 0.05,
                crossAxisCount: 2,
                children: allBrands,
              ),
            );
          },
        )
      ],
    );
  }

  List<Widget> cardGenerator(Size size) {
    List<Widget> allCards = [];
    for (int i = 0; i < 5; i++) {
      allCards.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedBrand = i;
            });
          },
          child: Container(
            height: size.width * 0.425,
            width: size.width * 0.425,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2.0),
                  blurRadius: 15.0,
                  spreadRadius: -10.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 2.50),
                  blurRadius: 10.0,
                  spreadRadius: -7.0,
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2.0),
                  blurRadius: 15.0,
                  spreadRadius: -10.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 2.50),
                  blurRadius: 10.0,
                  spreadRadius: -7.0,
                ),
              ],
              border: Border.all(color: selectedBrand == i ? colors.thirdColor : colors.cardsBorderColor, width: 2.5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Image.asset("assets/images/brand/${i + 1}.png"),
          ),
        ),
      );
    }
    return allCards;
  }
}
