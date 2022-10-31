import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: double.infinity),
            Text(
              "Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3),
            ),
            Avatar(image: "assets/images/other/avatar.jpeg"),
            Text(
              "Nawaf ahmed",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Text(
              "nawaf@gmail.com",
              style: TextStyle(fontSize: 15),
            ),
            ApplicationSettings()
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
