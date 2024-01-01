import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/music_player_page.dart';
import '../util/color.dart';
import '../util/play_music.dart';
class CustomNavBar {
  static Future<Widget> navBar() async{
   await AudioPlayerSingleton.recentMusicList();
   return InkWell(
      onTap: ()async{
        Get.to(()=>MusicPlayer(isAlreadyPlayMusic: true,callBack: (widget){
        },));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              RandomColors().getRandomColor(),
              RandomColors().getRandomColor()
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(30)
        ),
        height: 50,
        width: Get.size.width-20,
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.music_note_rounded, size: 35,),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AudioPlayerSingleton.selectedMusic?[AudioPlayerSingleton.musicIndex].title??"",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(AudioPlayerSingleton.selectedMusic?[AudioPlayerSingleton.musicIndex].artist??"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            InkWell(
              onTap: ()async{
                try {
                  if(AudioPlayerSingleton.isPlaying){
                     AudioPlayerSingleton.audioPlayer.pause();
                    AudioPlayerSingleton.isPlaying=false;
                  }
                  else{
                     AudioPlayerSingleton.playSongs(isNewMusic:false);
                  }
                 await AudioPlayerSingleton.updateBottomNavBar();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              child:AudioPlayerSingleton.isPlaying?const Icon(Icons.pause_circle_outlined,size: 35,) : const Icon(Icons.play_circle_outline_rounded, size: 35,),
            ),
            const SizedBox(width: 20,),
            InkWell(
              onTap: (){
                AudioPlayerSingleton.playNextSong();
              },
              child: const Icon(Icons.skip_next_rounded, size: 35,),
            ),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
