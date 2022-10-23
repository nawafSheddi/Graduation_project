import 'package:flutter/material.dart';
import 'package:sonar/styles/colors.dart' as colors;

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding,
    required this.isDangerous,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final bool isDangerous;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: padding == null ? const EdgeInsets.all(0.0) : padding!,
      child: ButtonTheme(
        minWidth: size.width * 0.9,
        height: 55,
        buttonColor: isDangerous ? Colors.red : colors.primaryColor,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
