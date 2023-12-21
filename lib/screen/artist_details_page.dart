import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/artist_details_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/songs_model.dart';
import 'music_player_page.dart';

class ArtistDetailsPage extends StatelessWidget {
   ArtistDetailsPage({super.key,required this.selectedArtist}){
     Get.delete<ArtistDetailsController>(force: true);
     Get.put(ArtistDetailsController(selectedArtist));
  }
   ArtistModel selectedArtist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: ()=>Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded)
        ),
        title: const Text("Artist Details",style: TextStyle(fontSize: 18),),
        centerTitle: true,
      ),
      body: GetBuilder<ArtistDetailsController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:controller.artistList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.artistList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: QueryArtworkWidget(
                        type: ArtworkType.AUDIO,
                        id: controller.artistList[index].id,
                        nullArtworkWidget: const Icon(Icons.music_note_sharp),
                      ),
                      title: Text(controller.artistList[index].title,style:const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(controller.artistList[index].artist??""),
                      onTap: () async{
                        var selectedSongs=SongList()
                        ..id=controller.artistList[index].id
                        ..genre=controller.artistList[index].genre
                        ..isAlarm=controller.artistList[index].isAlarm
                        ..isAudiobook=controller.artistList[index].isAudioBook
                        ..isMusic=controller.artistList[index].isMusic
                        ..isNotification=controller.artistList[index].isNotification
                        ..isPodcast=controller.artistList[index].isPodcast
                        ..isRingtone=controller.artistList[index].isRingtone
                        ..size=controller.artistList[index].size
                        ..title=controller.artistList[index].title
                        ..track=controller.artistList[index].track
                        ..uri=controller.artistList[index].uri
                        ..album=controller.artistList[index].album
                        ..albumArtist=controller.artistList[index].artist
                        ..albumId=controller.artistList[index].albumId
                        ..artist=controller.artistList[index].artist
                        ..data=controller.artistList[index].data
                        ..dateAdded=controller.artistList[index].dateAdded
                        ..dateModified=controller.artistList[index].dateModified
                        ..displayName=controller.artistList[index].displayName
                        ..displayNameWoExt=controller.artistList[index].displayNameWOExt
                        ..duration=controller.artistList[index].duration
                        ..fileExtension=controller.artistList[index].fileExtension
                        ..composer=controller.artistList[index].composer
                        ;
                        Get.to(()=>MusicPlayer(selectedMusic: selectedSongs,),);
                        // MusicPlayer(selectedMusic: selectedSongs,).musicPlayer(context);
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
