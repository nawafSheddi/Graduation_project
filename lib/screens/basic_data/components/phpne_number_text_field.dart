import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sonar/styles/colors.dart' as colors;

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      // height: ,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: colors.textFieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your Phone number';
          return null;
        },
        cursorColor: Colors.black,
        // cursorHeight: 15,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]'))
          // FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.name,
        textAlign: TextAlign.start,
        maxLength: 9,
        textDirection: TextDirection.ltr,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: "5XXXXXXXX",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: colors.textFieldColor),
          ),
          focusedBorder: OutlineInputBorder(
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
