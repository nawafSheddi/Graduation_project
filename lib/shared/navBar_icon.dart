import 'package:flutter/material.dart';
import 'package:sonar/providers/navBar_provider.dart';
import 'package:sonar/styles/colors.dart' as colors;

class NavBarIcon extends StatefulWidget {
  const NavBarIcon({
    Key? key,
    required this.icon,
    required this.index,
    required this.navBarProvider,
  }) : super(key: key);

  final IconData icon;
  final int index;
  final NavBarProvider navBarProvider;

  @override
  State<NavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<NavBarIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.navBarProvider.updateNavBar(widget.index, context);
      },
      child: Icon(
        widget.icon,
        size: 35,
        color: widget.navBarProvider.currentPage == widget.index ? Colors.white : colors.secondTextColor,
      ),
    );
  }
}
