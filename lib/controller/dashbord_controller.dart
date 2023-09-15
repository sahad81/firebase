import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController implements GetxService {


  int _pageIndex = 0;
  int get pageIndex=>_pageIndex;
  PageController? _pageController;
  PageController? get pageController => _pageController;

  void setPage(int pageIndex) {
    _pageController!.jumpToPage(pageIndex);
    _pageIndex = pageIndex;
    update();
  }
  initpage(){
    _pageController=PageController(initialPage: 0);
  }

}