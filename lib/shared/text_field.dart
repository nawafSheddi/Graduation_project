import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sonar/styles/colors.dart' as colors;

class MainTextField extends StatelessWidget {
  const MainTextField({Key? key, required this.controller, required this.hint}) : super(key: key);
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: colors.textFieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your name';
          return null;
        },
        cursorColor: Colors.black,
        // cursorHeight: 15,
        // inputFormatters: const [
        //   // FilteringTextInputFormatter.deny(RegExp("[0-9]")),
        //   // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
        //   // FilteringTextInputFormatter.digitsOnly
        // ],
        keyboardType: TextInputType.name,
        textAlign: TextAlign.start,

        textDirection: TextDirection.ltr,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: hint,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: colors.textFieldColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: colors.thirdColor),
          ),
        ),
      ),
    );
  }
}
