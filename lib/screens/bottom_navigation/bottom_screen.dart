import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_controller.dart';

class BottomScreen extends StatelessWidget {
  BottomScreen({super.key});
  BottomController bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: bottomController.screens[bottomController.cIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomController.cIndex.value,
          onTap: (value) {
            bottomController.cIndex.value = value;
          },
          type: BottomNavigationBarType.fixed, // or .shifting if you want a different style
          selectedItemColor: Color(0xFF6C58CF),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
