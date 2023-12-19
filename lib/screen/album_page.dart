import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/album_controller.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({super.key}){
    Get.put(AlbumController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumController>(
        builder: (controller) {
          return
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  controller.albums.isNotEmpty?
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.albums.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                      type: ArtworkType.ALBUM,
                      id: controller.albums[index].id,
                      nullArtworkWidget: const Icon(Icons.music_note_sharp),
                    ),
                      title: Text(controller.albums[index].artist??""),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(controller.albums[index].album),
                          Text("${controller.albums[index].numOfSongs}")
                        ],
                      ),
                );
              }):const Center(child: Text('Empty Album')),
            ),
          );
        }
    );
  }
}
