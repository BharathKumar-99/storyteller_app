import 'package:flutter/material.dart';
import 'package:storyteller/theme/theme.dart';

import '../util/routes/index.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      routerDelegate: appRoutes.router.routerDelegate,
      routeInformationProvider: appRoutes.router.routeInformationProvider,
      routeInformationParser: appRoutes.router.routeInformationParser,
    );
  }
}
