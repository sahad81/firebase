import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/screens/base/custom_button.dart';
import 'package:firebase_/screens/base/custome_text_filed.dart';
import 'package:firebase_/util/app_constants.dart';
import 'package:firebase_/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../util/dimensions.dart';
import 'base/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Center(
          child: Scrollbar(child: SingleChildScrollView(
            child: GetBuilder<AuthController>(builder: (authController) {
              return Container(
                  padding: context.width > 600
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : null,
                  width: context.width > 600 ? 600 : context.width,
                  decoration: context.width > 600
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                        )
                      : null,
                  child: !authController.loginInLogin
                      ? Column(
                        
                          children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                            Center(
                                child: Text(
                              AppConstants.appame,
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeOverLargeLarg,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 5),
                            )),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.04,
                            ),



                           Text('SIGN IN',style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                                 SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.04,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 90,
                                    child: CountryCodePicker(
                                      initialSelection: 'IND',
                                      alignLeft: false,
                                      showFlagDialog: true,
                                      showCountryOnly: true,
                                      onChanged: (value) {
                                        authController
                                            .contryCodeChange(value.toString());
                                      },
                                      showFlag: false,
                                      showOnlyCountryWhenClosed: false,
                                    )),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _phoneController,
                                    hintText: '  Phone Numnber',
                                    inputType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                            ),
                            authController.loginInLogin
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).cardColor)),
                                    child: CustomButton(
                                      onPressed: () {
                                        final String _phone =
                                            _phoneController.text.toString();

                                        if (_phone.isEmpty ||
                                            _phone.length < 10 ||
                                            _phone.length > 10) {
                                          showCustomSnackBar(
                                              'Enter a valied phone number',
                                              isError: true);
                                        } else {
                                          log(authController.contry_code
                                              .toString());
                                          authController.login(_phone);
                                          log(_phone);
                                        }
                                      },
                                      buttonText: 'Login',
                                      color: false,
                                    ),
                                  ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_OVER_LARGE,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.13,
                                  height: 1,
                                  color: Theme.of(context).cardColor,
                                ),
                                Text(
                                  ' Or Continue with ',
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.13,
                                  height: 1,
                                  color: Theme.of(context).cardColor,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_OVER_LARGE,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: Colors.blue.shade900),
                                  onPressed: () {
                                    authController.signInWithGoogle();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        right: 30,
                                        left: 30),
                                    child: authController.socialLogin
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 25,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                    'assets/images/google.png',
                                                  ),
                                                ),
                                              ),
                                              Text('Continue With Google',
                                                  style: robotoBlack.copyWith(
                                                      color: Theme.of(context)
                                                          .cardColor))
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                              color: Theme.of(context).primaryColor,
                              size: 50)));
            }),
          )),
        ),
      ),
    );
  }
}
