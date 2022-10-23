import 'package:flutter/material.dart';

class StepsCounter extends StatelessWidget {
  const StepsCounter({Key? key, required this.step}) : super(key: key);
  final int step;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(200)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: size.width * 0.3255),
      child: Text(
        "0$step/04",
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
