import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({Key? key, required this.label, this.onTap, this.child, required this.withPadding})
      : super(key: key);

  final String label;
  final Function()? onTap;
  final Widget? child;
  final bool withPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
                child == null ? const SizedBox() : child!,
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
