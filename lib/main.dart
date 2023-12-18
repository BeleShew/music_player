import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/home_controller.dart';
import 'package:music_player/screen/home_page.dart';

void main() {
  runApp(const MyApp());
  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: Colors.indigo,
            hintColor: Colors.deepOrange,
          ),
          themeMode: controller.themeMode,
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.bounceInOut,
          home: const HomePage()
        );
      },
    );
  }
}
