import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: ElevatedButton(
                                  onPressed: () {
                                    c.verifyOtp();
                                  },
                                  child: c.loginInLogin
                                      ? CircularProgressIndicator()
                                      : Text('verify')),
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
