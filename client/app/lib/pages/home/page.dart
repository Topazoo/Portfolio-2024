import 'package:app/pages/_templates/base_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flongo_client/widgets/widgets.dart';
import '../../navbar.dart';

class HomePage extends BaseImagePageTemplate {
  HomePage({super.key});

  @override
  final AppNavBar navbar = NavBar();
  // TODO - Replace base image
  final ImageProvider background = const NetworkImage('https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseImagePageTemplateState<HomePage> {

  @override
  Widget getHeroWidget(BuildContext context) {
    return const Center(
      child: Text(
        "Home Page",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 36,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          height: 1.5,
        ),
      ),
    );
  }
}
