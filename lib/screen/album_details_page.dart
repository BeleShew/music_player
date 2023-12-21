import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/album_details_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/songs_model.dart';
import 'music_player_page.dart';

class AlbumDetailsPage extends StatelessWidget {
  AlbumDetailsPage({super.key, required this.selectedAlbum}){
    Get.delete<AlbumDetailsController>(force: true);
    Get.put(AlbumDetailsController(selectedAlbum));
  }
  AlbumModel selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=>Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
        title: const Text("Album Details",style: TextStyle(fontSize: 18),),
        centerTitle: true,
      ),
      body: GetBuilder<AlbumDetailsController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:controller.songList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.songList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                        type: ArtworkType.AUDIO,
                        id: controller.songList[index].id??0,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.songList[index].title??"",style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.songList[index].artist??""),
                      onTap: () async{
                        Get.to(()=>MusicPlayer(selectedMusic: controller.songList,currentMusicIndex: index,));
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
          ),
        );
      }),
    );
  }
}
