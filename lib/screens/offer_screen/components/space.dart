import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: height ?? size.width * 0.02);
  }
}
