import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/songs_controller.dart';
import 'music_player_page.dart';

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
                      leading: QueryArtworkWidget(
                        type: ArtworkType.AUDIO,
                        id: controller.songList[index].id,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.songList[index].title),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(controller.songList[index].artist??""),
                          // Text("${controller.songList[index].album}")
                        ],
                      ),
                      onTap: () async{
                        Get.to(()=>MusicPlayer(selectedMusic: controller.songList[index],));
                        // await PlayAudioMusic.playMusic(url: controller.songList[index].uri??"");
                      },
                    );
                  }):const Center(child: Text('Empty Song')),
            ),
          );
        }
    );
  }
}
