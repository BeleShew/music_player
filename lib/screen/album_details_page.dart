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
                      title: Text(controller.songList[index].title,style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.songList[index].artist??""),
                      onTap: () async{
                        var selectedSongs=SongList()
                          ..id=controller.songList[index].id
                          ..genre=controller.songList[index].genre
                          ..isAlarm=controller.songList[index].isAlarm
                          ..isAudiobook=controller.songList[index].isAudioBook
                          ..isMusic=controller.songList[index].isMusic
                          ..isNotification=controller.songList[index].isNotification
                          ..isPodcast=controller.songList[index].isPodcast
                          ..isRingtone=controller.songList[index].isRingtone
                          ..size=controller.songList[index].size
                          ..title=controller.songList[index].title
                          ..track=controller.songList[index].track
                          ..uri=controller.songList[index].uri
                          ..album=controller.songList[index].album
                          ..albumArtist=controller.songList[index].artist
                          ..albumId=controller.songList[index].albumId
                          ..artist=controller.songList[index].artist
                          ..data=controller.songList[index].data
                          ..dateAdded=controller.songList[index].dateAdded
                          ..dateModified=controller.songList[index].dateModified
                          ..displayName=controller.songList[index].displayName
                          ..displayNameWoExt=controller.songList[index].displayNameWOExt
                          ..duration=controller.songList[index].duration
                          ..fileExtension=controller.songList[index].fileExtension
                          ..composer=controller.songList[index].composer
                        ;
                        Get.to(()=>MusicPlayer(selectedMusic: selectedSongs,));
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
