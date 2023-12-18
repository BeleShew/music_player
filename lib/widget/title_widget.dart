import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/title_controller.dart';
typedef TitleWidgetCallbacks = void Function(Widget selectedWidget);
class TitleWidget extends StatelessWidget {
   TitleWidget({super.key,required this.titleWidgetCallbacks}){
    Get.put(TitleController());
  }
   TitleWidgetCallbacks titleWidgetCallbacks;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TitleController>(
      builder: (controller) {
        return ListView.builder(
            itemCount: controller.titleList.length,
            shrinkWrap: true,
            scrollDirection:Axis.horizontal,
            itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              controller.selectedIndex=index;
              controller.buildTitleWidget();
              controller.buildSelectedHomePage();
              titleWidgetCallbacks.call(controller.homepage);
              controller.update();
            },
            child: Container(
              decoration:BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: controller.titleList[index],
              ),
            ),
          );
        });
      }
    );
  }
}


