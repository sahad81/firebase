
import 'dart:developer';

import 'package:firebase_/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  void changeScreen() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    bool loged = s.getBool('signed') ?? false;
  print('loged value: $loged');
    update();
    if (loged==true) {
      log('heyy');
      Get.offNamed(RouteHelper.gethomescreen());
    }else
    {
  Get.offNamed(RouteHelper.getloginscreen());
    }
  
  }
}
