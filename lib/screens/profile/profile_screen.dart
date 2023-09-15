import 'package:firebase_/controller/auth_controller.dart';
import 'package:firebase_/util/dimensions.dart';
import 'package:firebase_/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title:
                Text(FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Theme.of(context).cardColor,
                    )),
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return GetBuilder<AuthController>(
                          builder: (c) {
                            return AlertDialog(
                              title: Text('Confirm Logout'),
                              content: Text('Are you sure you want to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('NO'),
                                ),
                                TextButton(
                                  onPressed: (){
c.logOut(context);
                                  } ,// Call the logout function
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          }
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.logout))
            ],
          )
        ],
      ),
    );
  }
}
