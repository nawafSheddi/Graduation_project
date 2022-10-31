import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonar/providers/navBar_provider.dart';
import 'package:sonar/shared/navBar_icon.dart';
import 'package:sonar/styles/colors.dart' as colors;

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<NavBarProvider>(
      builder: (context, navBarProvider, child) {
        return Container(
          height: size.height * 0.1,
          padding: EdgeInsets.all(size.width * 0.05),
          decoration: const BoxDecoration(color: colors.primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBarIcon(
                navBarProvider: navBarProvider,
                icon: Icons.home_rounded,
                index: 0,
              ),
              NavBarIcon(
                navBarProvider: navBarProvider,
                icon: Icons.favorite_border_rounded,
                index: 1,
              ),
              NavBarIcon(
                navBarProvider: navBarProvider,
                icon: Icons.add_circle_outline_rounded,
                index: 2,
              ),
              NavBarIcon(
                navBarProvider: navBarProvider,
                icon: Icons.person_rounded,
                index: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
