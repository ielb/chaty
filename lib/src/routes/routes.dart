import 'package:chaty/src/extensions/extensions.dart';
import 'package:chaty/src/screens/auth/login_screen.dart';
import 'package:chaty/src/screens/auth/register_screen.dart';
import 'package:chaty/src/screens/home_screen.dart';
import 'package:chaty/src/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  Routes._privateConstructor();
  static Routes instance = Routes._privateConstructor();

  String initialRoute = SplashScreen.id;

  Route<dynamic>? availableRoutes(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case SplashScreen.id:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case LoginScreen.id:
        return CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RegisterScreen.id:
        return CupertinoPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
