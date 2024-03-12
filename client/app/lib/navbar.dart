import 'package:flongo_client/utilities/transitions/fade_to_black_transition.dart';
import 'package:flongo_client/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavBar extends AppNavBar {
  @override
  List<NavBarItem> getNavbarItems() => [
    NavBarItem(
      icon: Icons.home,
      title: 'Home',
      routeName: '/home',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
      inaccessibleRoutes: ['/']
    ),

    NavBarItem(
      icon: Icons.person,
      title: 'About Me',
      routeName: '/about_me',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
    ),
  ];
}