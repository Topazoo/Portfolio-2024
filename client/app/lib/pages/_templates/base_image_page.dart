import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flongo_client/pages/base_page.dart';
import 'package:flongo_client/widgets/widgets.dart';
import '../../navbar.dart';
import 'custom_drawer.dart';

class BaseImagePageTemplate extends BasePage {
  BaseImagePageTemplate({super.key});

  @override
  final AppNavBar navbar = NavBar();
  // TODO - Replace base image
  final ImageProvider background = const NetworkImage('https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');

  final GlobalKey footerKey = GlobalKey();
  final GlobalKey headerKey = GlobalKey();

  @override
  BaseImagePageTemplateState createState() => BaseImagePageTemplateState();
}

class BaseImagePageTemplateState<T extends BaseImagePageTemplate> extends BasePageState<BaseImagePageTemplate> {
  //BasePageState<T extends BasePage> extends State<T>
  @override
  Widget getPageWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildHeroSection(context),
      ],
    );
  }

  @protected
  Widget getHeroWidget(BuildContext context) {
    return const Center(
      child: Text(
        "Home",
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

  @override
  AppBar getPageHeaderWidget(BuildContext context) => AppBar(
    key: widget.headerKey,
    backgroundColor: Colors.white.withOpacity(.1),
    elevation: 0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu, size: 40), // Increased hamburger icon size
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: const Text(
      "Peter Swanson's Portfolio",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    actions: getHeaderAppBarWidgets(context),
    toolbarHeight: 60,
  );

  @override
  Widget getPageFooterWidget(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      key: widget.footerKey,
      padding: isSmallScreen ? const EdgeInsets.all(10) : const EdgeInsets.all(20),
      color: AppTheme.accentTextColor.withOpacity(.3),
      child: Wrap(
        alignment: isSmallScreen ? WrapAlignment.center : WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '© ${DateTime.now().year} Peter Swanson',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min, // Ensures the row takes minimum space required
            children: [
              TextButton(
                child: const Text('Terms of Service', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ],
          ),
        ]
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.background,
          fit: BoxFit.cover,
        ),
      ),
      child: getHeroWidget(context)
    );
  }

  @override
  List<Widget> getStaticNavbarItems(BuildContext context) {
    return widget.navbar.getNavbarItems().map((item) {
      return Material(
        color: Colors.transparent,
        child: ListTile(
          leading: Icon(item.icon, color: Colors.white),
          title: Text(item.title, style: const TextStyle(color: Colors.white)),
          hoverColor:Colors.white12,
          onTap: () {
            if (![item.routeName, ...item.inaccessibleRoutes].contains(ModalRoute.of(context)?.settings.name)) {
              Navigator.of(context).pushReplacementNamed(
                item.routeName,
                arguments: item.routeArguments,
              );
            }
          },
        ),
      );
    }).toList();
  }

  @override
  Widget getPageDrawerWidget(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.33; // Drawer width is 33% of the screen width

    return Align(
      alignment: Alignment.topLeft,
      child: CustomDrawer(
        width: drawerWidth,
        menuItems: [
          _buildDrawerHeader(context), // TODO - Animated LOGO
          ...getStaticNavbarItems(context),
          ...getDynamicNavbarItems(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: const Center(
        child: FlutterLogo(size: 60.0), // TODO - Animated LOGO
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows the body to extend behind the AppBar
      extendBodyBehindAppBar: true,
      appBar: getPageHeaderWidget(context),
      body: getPageWidget(context),
      drawer: getPageDrawerWidget(context),
      bottomNavigationBar: getPageFooterWidget(context),
    );
  }
}
