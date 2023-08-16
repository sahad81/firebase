import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_/helper/route_helper.dart';
import 'package:firebase_/model/register_model.dart';
import 'package:firebase_/screens/base/custom_snackbar.dart';
import 'package:firebase_/screens/verifiaction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  String? _number = '';
  bool _loadingInLogin = false;
  bool get loginInLogin => _loadingInLogin;
  String? _country_code;
  String? get contry_code => _country_code;
  String? get number => _number;
  String? _verificationId;
  String? get verificationId => _verificationId;
  String? _uid;
  String? get uid => _uid;
  String _verificationCode = '';
  File? _imagepath;
  File? get imagePath => _imagepath;
  String get verificationCode => _verificationCode;
  final FirebaseStorage firStore = FirebaseStorage.instance;
  final FirebaseAuth fireauth = FirebaseAuth.instance;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  void contryCodeChange(value) {
    _country_code = '';
    _country_code = value;
    update();
    log(_country_code.toString());
  }

  void login(String phone) async {
    _loadingInLogin = true;
    update();
    verificationCompleted(AuthCredential cridential) {
      log("${cridential.toString()}------------completed");
      _loadingInLogin = false;
      update();
    }

    verificationFaild(FirebaseAuthException cridential) {
      log("-----------error${cridential.message.toString()}");
      _loadingInLogin = false;
      showCustomSnackBar(cridential.message);
      update();
    }

    sentcode(String verId, [int? foreceCodeset]) {
      _verificationId = verId;
      _loadingInLogin = false;
      update();
      Get.to(const VerificationScreen());
    }

// ignore: non_constant_identifier_names
    PhonecodeAUthRetraiveltimeout(String verId) {
      _verificationId = verId;
      _loadingInLogin = false;
      update();
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phone.toString()}",
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFaild,
        codeSent: sentcode,
        codeAutoRetrievalTimeout: PhonecodeAUthRetraiveltimeout);
  }

  verifyOtp() async {
    _loadingInLogin = true;
    update();
    try {
      PhoneAuthCredential crds = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: _verificationCode);
      User? user =
          (await FirebaseAuth.instance.signInWithCredential(crds)).user;

      if (user != null) {
        _uid = user.uid;
        update();
        SharedPreferences s = await SharedPreferences.getInstance();
        s.setString('uid', user.uid);
        log(_uid.toString());

        await checkExisting();
      }
      _loadingInLogin = false;
      update();
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message);
      _loadingInLogin = false;
      update();
    }
  }

  checkExisting() async {
    try {
      final userr = FirebaseAuth.instance;
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      update();
      log("----------${snapshot.toString()}");
      if (snapshot.exists) {
        log('old user');
        SharedPreferences s = await SharedPreferences.getInstance();
        s.setBool('signed', true);
        Get.toNamed(RouteHelper.homescreen);
        Get.offAllNamed(RouteHelper.gethomescreen());
      } else {
        log('new ');
        Get.offAllNamed(RouteHelper.register);
      }

      update();
    } catch (e) {
      log(e.toString());
    }
  }

//stor date in fire store
  Future storeData(RegisterModel registerModel) async {
    try {
      _loadingInLogin = true;
      update();
      log('--------------------------------${_uid.toString()}');
      FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .set(registerModel.tojson())
          .then((value) async {
        SharedPreferences s = await SharedPreferences.getInstance();

        s
            .setString('user_model', jsonEncode(registerModel.tojson()))
            .then((value) async {});
      });
      _loadingInLogin = false;
      update();
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<String?> storefiletofirestore(String ref, File file) async {
    UploadTask uploadtast = firStore.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadtast;
    String dowloadUrl = await snapshot.ref.getDownloadURL();
    return dowloadUrl;
  }

  Future<File?> pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imagepath = File(pickedImage.path);
        update();
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    return _imagepath;
  }
}
