import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_/model/register_model.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  RegisterModel? _personalDetail;
  RegisterModel? get personaldata => _personalDetail;
  final firestore = FirebaseFirestore.instance;

  void getpersonaldetails() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    final uid = s.getString('uid');
//    _personalDetail = await firestore.collection('users').doc(uid);;
  }
}
