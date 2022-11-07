import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/personal_info.dart';
import 'package:sonar/screens/profile/components/application_settings.dart';
import 'package:sonar/screens/profile/components/avatar.dart';
import 'package:sonar/shared/navBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = "/profile-screen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<PersonalInfo>(
          builder: (context, personalInfo, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
                ),
                const Avatar(image: "assets/images/other/avatar.jpeg"),
                Text(
                  personalInfo.name,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Text(
                  personalInfo.email,
                  style: const TextStyle(fontSize: 15),
                ),
                const ApplicationSettings(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
