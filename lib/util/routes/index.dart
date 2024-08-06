import 'package:flutter/material.dart';
import 'router.dart';
import 'routes_constants.dart';

RouteConstants routeName = RouteConstants();
Routes appRoutes = Routes();

BuildContext? get ctx =>
    appRoutes.router.routerDelegate.navigatorKey.currentContext;
