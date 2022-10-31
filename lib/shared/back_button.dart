import 'package:flutter/material.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({Key? key, this.onPressed, this.padding}) : super(key: key);

  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: size.height * 0.06, left: size.width * 0.05),
        child: GestureDetector(
          onTap: onPressed ??
              () {
                Navigator.pop(context);
              },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
