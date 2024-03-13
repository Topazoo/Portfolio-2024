import 'package:flongo_client/utilities/transitions/fade_to_black_transition.dart';
import 'package:flongo_client/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavBar extends AppNavBar {
  @override
  List<NavBarItem> getNavbarItems() => [
    NavBarItem(
      icon: Icons.home,
      title: 'Home',
      routeName: '/',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
      inaccessibleRoutes: ['/']
    ),

    NavBarItem(
      icon: Icons.person,
      title: 'About Me',
      routeName: '/about_me',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
    ),

    NavBarItem(
      icon: Icons.playlist_add_check_circle,
      title: 'Projects',
      routeName: '/projects',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
    ),

    NavBarItem(
      icon: Icons.token,
      title: 'Packages',
      routeName: '/packages',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
    ),

    NavBarItem(
      icon: Icons.contact_emergency,
      title: 'Contact',
      routeName: '/contact',
      routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400},
    ),
  ];
}