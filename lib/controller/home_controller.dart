import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/title_controller.dart';

import '../widget/bottom_navigation_bar.dart';

class HomeController extends GetxController {
  ThemeMode themeMode =ThemeMode.dark;
  bool isDarkTheme=true;
  Widget currentWidget=Get.put(TitleController()).homepage;
  Widget bottomNavBarWidget=Container();
  updateThemeMode({required ThemeMode themeModes}){
    themeMode=themeModes;
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    bottomNavBarWidget=await CustomNavBar.navBar();
    update();
  }
}