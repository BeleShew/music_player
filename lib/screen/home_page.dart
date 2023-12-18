import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/home_controller.dart';
import 'package:music_player/screen/album_page.dart';
import 'package:music_player/screen/playlist_page.dart';
import 'package:music_player/screen/songs_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widget/title_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Music",),
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                controller.isDarkTheme=!controller.isDarkTheme;
                if(controller.isDarkTheme){
                  controller.updateThemeMode(themeModes: ThemeMode.dark);
                }
                else{
                  controller.updateThemeMode(themeModes: ThemeMode.light);
                }
                controller.update();
              },
                child: Icon(controller.isDarkTheme?Icons.dark_mode_rounded:Icons.light_mode_rounded,size: 24,),
            ),
          ),
          body:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
                child: TitleWidget(titleWidgetCallbacks: (Widget selectedWidget) {
                  controller.currentWidget=selectedWidget;
                  controller.update();
                },),
              ),
              Expanded(child: controller.currentWidget)
            ],
          )
        );
      },
    );
  }
}
