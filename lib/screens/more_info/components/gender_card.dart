import 'package:flutter/material.dart';
import 'package:sonar/styles/colors.dart' as colors;

class GenderCard extends StatelessWidget {
  const GenderCard({Key? key, required this.isMale, required this.isSelected, required this.onTap}) : super(key: key);

  final bool isMale;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.3,
        height: size.width * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: colors.textFieldColor,
          border: Border.all(color: isSelected ? colors.thirdColor : colors.cardsBorderColor, width: 2.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(isMale ? Icons.man_rounded : Icons.woman_rounded, size: 60),
            Text(isMale ? "Man" : "Women"),
          ],
        ),
      ),
    );
  }
}
