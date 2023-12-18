import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/title_controller.dart';

class HomeController extends GetxController {
  ThemeMode themeMode =ThemeMode.dark;
  bool isDarkTheme=true;
  Widget currentWidget=Get.put(TitleController()).homepage;
  updateThemeMode({required ThemeMode themeModes}){
    themeMode=themeModes;
    update();
  }
}