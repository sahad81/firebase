import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/screens/base/custom_button.dart';
import 'package:firebase_/screens/base/custome_text_filed.dart';
import 'package:firebase_/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Center(
          child: Scrollbar(child: SingleChildScrollView(
            child: GetBuilder<AuthController>(builder: (AuthController) {
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
                child: Column(
                  children: [
                    const Center(
                      child: Text(AppConstants.appame),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
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
                                AuthController.contryCodeChange(
                                    value.toString());
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
                      height: 30,
                    ),
                 AuthController.loginInLogin?
                 CircularProgressIndicator(strokeWidth: 2,):
                    CustomButton(
                      onPressed: () {
                        final String _phone = _phoneController.text.toString();

                        if (_phone.isEmpty ||
                            _phone.length < 10 ||
                            _phone.length > 10) {
                          showCustomSnackBar('Enter a valied phone number',
                              isError: true);
                        } else {
                          log(AuthController.contry_code.toString());
                          AuthController.login(_phone);
                          log(_phone);
                        }
                      },
                      buttonText: 'Login',
                      color: true,
                    )
                  ],
                ),
              );
            }),
          )),
        ),
      ),
    );
  }
}
