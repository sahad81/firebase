import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/screens/base/custom_button.dart';
import 'package:firebase_/util/dimensions.dart';
import 'package:firebase_/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.Phone});
  final String Phone;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Scrollbar(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: context.width > 700 ? 700 : context.width,
              padding: context.width > 700 ? EdgeInsets.all(25) : null,
              decoration: context.width > 700
                  ? BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    )
                  : null,
              child: GetBuilder<AuthController>(builder: (c) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Verification',
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeOverLarge)),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      Text(
                        "Please enter the verification code that we sent to your Phone Number ${widget.Phone}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_OVER_LARGE,
                      ),
                      PinCodeTextField(
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.slide,
                        appContext: context,
                        length: 6,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 60,
                          fieldWidth: 60,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(10),
                          selectedColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          selectedFillColor: Colors.white,
                          inactiveFillColor:
                              Theme.of(context).disabledColor.withOpacity(0.2),
                          inactiveColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          activeColor:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          activeFillColor:
                              Theme.of(context).disabledColor.withOpacity(0.2),
                        ),
                        onChanged: c.updateVerificationCode,
                        beforeTextPaste: (text) => true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      c.verificationCode.length == 6
                          ? SizedBox(
                              width: context.width,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: c.loginInLogin
                                      ? LoadingAnimationWidget.dotsTriangle(
                                          color: Theme.of(context).primaryColor,
                                          size: 50)
                                      : CustomButton(
                                          radius: Dimensions.RADIUS_EXTRA_LARGE,
                                          buttonText: 'Verify',
                                          onPressed: () {
                                            c.verifyOtp();
                                          },
                                        )),
                            )
                          : SizedBox()
                    ],
                  ),
                );
              }),
            ),
          ),
        )),
      ),
    );
  }
}
