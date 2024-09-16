import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

class BottomController extends GetxController {
  RxInt cIndex = 0.obs;
  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
}
