import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final double width;
  final List<Widget> menuItems;

  CustomDrawer({
    required this.width,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Set your desired opacity here
      ),
      child: Column(
        children: menuItems,
      ),
    );
  }
}
