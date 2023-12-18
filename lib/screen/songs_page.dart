import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/playlist_controller.dart';

import '../controller/songs_controller.dart';

class SongsPage extends StatelessWidget {
  SongsPage({super.key}){
    Get.put(SongsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SongsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  controller.songList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.songList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: const Icon(Icons.music_note_sharp),
                      title: Text(controller.songList[index].artist??""),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(controller.songList[index].displayName),
                          Text("${controller.songList[index].album}")
                        ],
                      ),
                    );
                  }):const Center(child: Text('Empty Song')),
            ),
          );
        }
    );
  }
}
