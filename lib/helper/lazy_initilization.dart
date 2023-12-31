
import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/controller/dashbord_controller.dart';
import 'package:firebase_/controller/home_controller.dart';
import 'package:firebase_/controller/spash_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future init() async {
 Get.lazyPut(() => SplashController()); Get.lazyPut(() => AuthController());
 Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => HomeController());
}