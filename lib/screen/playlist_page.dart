import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/playlist_controller.dart';

class PlayListPage extends StatelessWidget {
   PlayListPage({super.key}){
    Get.put(PlayListController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.playList.isNotEmpty?
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.playList.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: const Icon(Icons.music_note_sharp),
                    title: Text(controller.playList[index].playlist),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(controller.playList[index].data??""),
                        Text("${controller.playList[index].numOfSongs}")
                      ],
                    ),
                  );
                }):const Center(child: Text('Empty Play List')),
          ),
        );
      }
    );
  }
}
