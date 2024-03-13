import 'package:app/pages/_templates/base_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flongo_client/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

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

class _HomePageState extends BaseImagePageTemplateState<HomePage> with TickerProviderStateMixin {
  final Random _random = Random();
  List<Offset> _starPositions = [];
  late final AnimationController _animationController;
  double? _appBarHeight;
  double? _footerHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    // Generate positions after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureFooter();
      _generateStarPositions();
    });
  }

  void _measureFooter() {
    final RenderBox? footerBox = widget.footerKey.currentContext?.findRenderObject() as RenderBox?;
    if (footerBox != null) {
      _footerHeight = footerBox.size.height;
    } else {
      // Fallback or default value in case the footerBox is not available
      _footerHeight = 60.0; // Consider using a default height or another handling mechanism
    }
  }

  void _generateStarPositions() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const edgeMargin = 150.0; // Margin from the edge of the screen
    final safeTop = AppBar().preferredSize.height;
    final safeBottom = screenHeight - ((_footerHeight ?? 60.0 + edgeMargin) + 250);
    const safeLeft = 10;
    final safeRight = screenWidth - edgeMargin;

    // Define a minimum distance between stars to prevent overlap
    const minStarDistance = 180.0;

    // Generate star positions with constraints
    List<Offset> positions = [];
    for (int i = 0; i < widget.navbar.getNavbarItems().length; i++) {
      Offset newPos;
      bool tooClose;
      do {
        tooClose = false;
        newPos = Offset(
          _random.nextDouble() * (safeRight - safeLeft) + safeLeft,
          _random.nextDouble() * (safeBottom - safeTop) + safeTop,
        );
        // Ensure newPos is not too close to other stars
        for (Offset pos in positions) {
          if ((pos - newPos).distance < minStarDistance) {
            tooClose = true;
            break;
          }
        }
      } while (tooClose);

      positions.add(newPos);
    }

    setState(() {
      _starPositions = positions;
    });
  }

  @override
  Widget getHeroWidget(BuildContext context) {
    // Positions must be regenerated on every build to adapt to possible layout changes
    _generateStarPositions();
    return Stack(
      children: _buildStarNavItems(context),
    );
  }

  List<Widget> _buildStarNavItems(BuildContext context) {
    final navItems = widget.navbar.getNavbarItems()..removeWhere((element) => element.routeName == '/');

    return List.generate(navItems.length, (index) {
      final navItem = navItems[index];
      final position = _starPositions[index];

      return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(navItem.routeName);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none, // Allows the text to be positioned outside the stack
              children: <Widget>[
                Lottie.asset(
                  'assets/animations/white_star_fast.json',
                  width: 200,
                  height: 200,
                  repeat: false,
                ),
                Positioned(
                  bottom: 20, // Adjust as necessary to move text closer to the star
                  child: FadeTransition(
                    opacity: _animationController,
                    child: Text(
                      navItem.title,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}