import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sonar/screens/profile/components/settings_row.dart';
import 'package:sonar/screens/profile/components/toggle.dart';

class ApplicationSettings extends StatefulWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  State<ApplicationSettings> createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 50, left: size.width * 0.05, right: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: double.infinity),
          const Text(
            "Application Settings",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SettingsRow(
            label: "Notification",
            withPadding: true,
            child: FlutterSwitch(
              width: 70,
              height: 32.5,
              valueFontSize: 14.0,
              toggleSize: 20.0,
              value: status,
              borderRadius: 30.0,
              padding: 8.0,
              showOnOff: true,
              activeColor: Colors.green,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
              },
            ),
          ),
          const SettingsRow(
            withPadding: false,
            label: "Terms of use",
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xffB1B5C3),
            ),
          ),
          const SettingsRow(
            withPadding: false,
            label: "Privacy Policy",
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xffB1B5C3),
            ),
          ),
          const SettingsRow(
            withPadding: false,
            label: "About",
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xffB1B5C3),
            ),
          ),
        ],
      ),
    );
  }
}
