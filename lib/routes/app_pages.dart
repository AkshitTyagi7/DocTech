import 'package:doctech/createCharacter/createCharacter.dart';
import 'package:doctech/screens/homeScreen/home_screen.dart';
import 'package:doctech/screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';

import '../screens/splash/splash.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.splashRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.splashRoute: (context) => const Splash(),
    Routes.homeRoute: (context) => const HomeScreen(),
    Routes.login: (context) => const LoginScreen(),
    Routes.createCharacter: (context) => const CreateCharacter(),
  };
}
