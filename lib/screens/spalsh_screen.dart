import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/spash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
   @override
     void initState() {

Future.delayed(Duration(seconds: 5)).then((value) =>Get.find<SplashController>().changeScreen()


);

       super.initState();
     



   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Center(
        child:  Text('Learn about firebse '.toUpperCase()),
      ),
    );
  }
}