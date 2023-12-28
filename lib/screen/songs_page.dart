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
            controller:controller.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isLoadAllData&& controller.simplifiedSongs.songList!=null&& controller.simplifiedSongs.songList!.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.simplifiedSongs.songList?.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                        type: ArtworkType.AUDIO,
                        id: controller.simplifiedSongs.songList?[index].id??0,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.simplifiedSongs.songList?[index].title??"",style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.simplifiedSongs.songList?[index].artist??""),
                      onTap: () async{
                        Get.to(()=>MusicPlayer(selectedMusic: controller.simplifiedSongs.songList??[], currentMusicIndex: index,isPlayMusic: true,));
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
