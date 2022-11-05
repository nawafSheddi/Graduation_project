import 'package:flutter/material.dart';

class FeaturesRow extends StatelessWidget {
  const FeaturesRow({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.access_time_rounded),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
