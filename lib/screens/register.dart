
import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/helper/date_converter.dart';
import 'package:firebase_/model/register_model.dart';
import 'package:firebase_/screens/base/custom_button.dart';
import 'package:firebase_/screens/base/custom_snackbar.dart';
import 'package:firebase_/screens/base/custome_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/circular_reveal_clipper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER '),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SafeArea(
          child: Scrollbar(
              child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AuthController>(builder: (c) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      c.pickImage();
                    },
                    child: c.imagePath != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(c.imagePath!),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            child: Icon(
                              Icons.account_circle,
                              size: 50,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: bioController,
                  hintText: 'Bio',
                ),
                SizedBox(
                  height: 20,
                ),
                c.loginInLogin
                    ? CircularProgressIndicator()
                    : CustomButton(
                        buttonText: 'Register',
                        onPressed: () async {
                          final _bio = bioController.text.trim();
                          final _name = nameController.text.trim();
                          final _email = emailController.text.trim();

                          if (_name.isEmpty) {
                            showCustomSnackBar('Enter your Name');
                          } else if (_email.isEmpty) {
                            showCustomSnackBar('Enter Email address');
                          } else if (_bio.isEmpty) {
                            showCustomSnackBar('Enter Bio');
                          } else {
                            c.storeData(RegisterModel(
                              bio: _bio,
                              createdAt: DateConverter.dateToDateAndTime(
                                  DateTime.now()),
                              email: _email,
                              name: _name,
                              phone: FirebaseAuth
                                  .instance.currentUser!.phoneNumber,
                              // Use `await` to wait for the image URL to be fetched
                              image: c.imagePath != null
                                  ? await c.storefiletofirestore(
                                      'profilepic${c.uid}', c.imagePath!)
                                  : '',
                              uid: FirebaseAuth.instance.currentUser!.uid,
                            ));
                          }
                        },
                      )
              ],
            );
          }),
        ),
      ))),
    );
  }
}
