import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/album_details_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumDetailsPage extends StatelessWidget {
  AlbumDetailsPage({super.key, required this.selectedAlbum}){
    Get.delete<AlbumDetailsController>(force: true);
    Get.put(AlbumDetailsController(selectedAlbum));
  }
  AlbumModel selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      title: Text(controller.songList[index].title,style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.songList[index].artist??""),
                      onTap: () async{
                        // Get.to(()=>MusicPlayer(selectedMusic: controller.songList?[index]??SongList(),));
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
