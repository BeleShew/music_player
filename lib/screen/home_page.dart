import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/home_controller.dart';
import '../widget/bottom_navigation_bar.dart';
import '../widget/title_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Music",style: TextStyle(fontSize: 18),),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 35,
                child: TitleWidget(titleWidgetCallbacks: (Widget selectedWidget) {
                  controller.currentWidget=selectedWidget;
                  controller.update();
                },),
              ),
              const SizedBox(height: 10,),
              Expanded(child: controller.currentWidget)
            ],
          ),
          bottomNavigationBar:BottomNavBar(),
          // bottomNavigationBar:controller.selectedMusic!=null &&controller.selectedMusic!.isNotEmpty? BottomNavBar(selectedMusic: controller.selectedMusic??[],musicIndex: controller.musicIndex,):Container(height: 5,),
        );
      },
    );
  }
}
