
import 'package:flongo_client/pages/json_page.dart';
import 'package:flongo_client/widgets/navbar/app_navbar.dart';
import 'package:flutter/material.dart';

import '../../navbar.dart';
import 'json_widget.dart';

class ConfigPage extends JSON_Page {
  @override
  final String apiURL = '/config';
  @override
  final bool fetchOnLoad = true;
  @override
  final bool authenticationRequired = true;
  @override
  final AppNavBar navbar = NavBar();

  ConfigPage({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends JSON_PageState {
  @override
  Widget getPageWidget(BuildContext context) => ConfigJSONWidget(
    data: data, 
    apiURL: widget.apiURL,
    onRefresh: fetchData
  );
}
