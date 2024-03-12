import 'package:app/pages/home/page.dart';
import 'package:app/pages/splash/page.dart';
import 'package:app/theme.dart';

import 'package:flongo_client/app.dart';
import 'package:flongo_client/app_router.dart';
import 'package:flutter/material.dart';

final FlongoApp flongoApp = FlongoApp(

  router: AppRouter(
    routeBuilders: {
      '/': (context, args) => HomePage(),
      '/_splash': (context, args) => const SplashScreen(),
    },
  ),

  initialRoute: '/_splash',
  
  appTheme: ThemeData(primarySwatch: AppTheme.primarySwatch),
);
