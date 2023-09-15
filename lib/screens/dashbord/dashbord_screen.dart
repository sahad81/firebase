import 'package:firebase_/controller/dashbord_controller.dart';
import 'package:firebase_/screens/dashbord/widget/bottom_nav_item.dart';
import 'package:firebase_/screens/home_screen.dart';
import 'package:firebase_/screens/msg/msg_screen.dart';
import 'package:firebase_/screens/profile/profile_screen.dart';
import 'package:firebase_/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget>? _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Get.find<DashboardController>().initpage();
    _screens = [
      HomeScreen(),
      Container(),
      Container(),
      MessageScreen(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      floatingActionButton: ClipOval(
        child: Builder(builder: (context) {
          return GetBuilder<DashboardController>(builder: (c) {
            return FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                elevation: 5,
                backgroundColor: c.pageIndex == 2
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).bottomAppBarTheme.color,
                onPressed: () => Get.find<DashboardController>().setPage(2),
                child: Container(
                  width: 30,
                  height: 30,
                  child: const Center(
                    child: Icon(Icons.post_add),
                  ),
                ));
          });
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.08,
        elevation: 10,
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: GetBuilder<DashboardController>(builder: (c) {
            return Row(children: [
              BottomNavItem(
                  iconData: Icons.home,
                  isSelected: c.pageIndex == 0,
                  onTap: () => c.setPage(0)),
              BottomNavItem(
                  iconData: Icons.favorite,
                  isSelected: c.pageIndex == 1,
                  onTap: () => c.setPage(1)),
              Expanded(child: SizedBox()),
              BottomNavItem(
                  iconData: Icons.message,
                  isSelected: c.pageIndex == 3,
                  onTap: () => c.setPage(3)),
              BottomNavItem(
                  iconData: Icons.person,
                  isSelected: c.pageIndex == 4,
                  onTap: () => c.setPage(4)),
            ]);
          }),
        ),
      ),
      body: GetBuilder<DashboardController>(builder: (c) {
        return PageView.builder(
          controller: c.pageController,
          itemCount: _screens?.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        );
      }),
    );
  }
}
