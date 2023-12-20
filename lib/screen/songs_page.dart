import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/songs_controller.dart';
import '../model/songs_model.dart';
import 'music_player_page.dart';

class SongsPage extends StatelessWidget {
  SongsPage({super.key}){
    // Get.lazyPut(()=>SongsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SongsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isLoadAllData&& controller.allSongs.songList!=null&& controller.allSongs.songList!.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (controller.allSongs.songList!.length/20).ceil(),
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                        type: ArtworkType.AUDIO,
                        id: controller.allSongs.songList?[index].id??0,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.allSongs.songList?[index].title??""),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(controller.allSongs.songList?[index].artist??""),
                          // Text("${controller.songList[index].album}")
                        ],
                      ),
                      onTap: () async{
                        Get.to(()=>MusicPlayer(selectedMusic: controller.allSongs.songList?[index]??SongList(),));
                        // await PlayAudioMusic.playMusic(url: controller.songList[index].uri??"");
                      },
                    );
                  }):
               Center(
                  child: CircularProgressIndicator(
                    // color: Colors.green.shade200,
                    valueColor:AlwaysStoppedAnimation<Color>(Colors.red.shade300),
                    backgroundColor: Colors.yellow.shade200,
                    strokeWidth:2,
              ),
              ),
            ),
          );
        }
    );
  }
}
