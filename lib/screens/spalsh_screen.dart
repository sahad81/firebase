import 'package:firebase_/util/dimensions.dart';
import 'package:firebase_/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/spash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5))
        .then((value) => Get.find<SplashController>().changeScreen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HAPPOP'.toUpperCase(),

              style: robotoBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeOverLargeLarg,
                  letterSpacing: 5),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
            LoadingAnimationWidget.dotsTriangle(
                color: Theme.of(context).primaryColor, size: 40)
          ],
        ),
      ),
    );
  }
}
