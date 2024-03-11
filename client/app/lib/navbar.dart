import 'package:flongo_client/utilities/http_client.dart';
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

    if (HTTPClient.isAuthenticated()) ...[
      NavBarItem(
        icon: Icons.person,
        title: 'User',
        routeName: '/user',
        routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400}
      ),
    ],

    if (HTTPClient.isAdminAuthenticated()) ...[
      NavBarItem(
        icon: Icons.people,
        title: 'Users',
        routeName: '/users',
        routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400}
      ),
      NavBarItem(
        icon: Icons.settings,
        title: 'Config',
        routeName: '/config',
        routeArguments: {"_animation": FadeToBlackTransition.transitionsBuilder, "_animation_duration": 400}
      ),
    ]
  ];

  @override
  Widget getNavbarHeader() => UserAccountsDrawerHeader(
    accountName: Text(HTTPClient.getUsername() ?? 'Guest'),
    accountEmail: Text(HTTPClient.isAuthenticated() ? "Email: ${HTTPClient.getEmail() ?? 'None'}" : 'Please Login'),
    currentAccountPicture: const CircleAvatar(backgroundColor: Colors.black38),
    decoration: BoxDecoration(color: Colors.blueGrey[900]),
  );
}