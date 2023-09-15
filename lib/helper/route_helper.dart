import 'package:firebase_/screens/dashbord/dashbord_screen.dart';
import 'package:firebase_/screens/home_screen.dart';
import 'package:firebase_/screens/register.dart';
import 'package:firebase_/screens/spalsh_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/login_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String homescreen = '/home';
  static const String loginscreen = '/login';
  static const String register = '/register';
  static const String dashboardScreen = '/dashboard';

  static String gethomescreen() => homescreen;
  static String getloginscreen() => loginscreen;

  static List<GetPage> routes = [
    GetPage(
      name: homescreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: loginscreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashboardScreen(pageIndex: 1),
    ),
      GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
  ];
}
