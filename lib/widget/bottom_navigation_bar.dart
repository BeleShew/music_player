import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/music_player_page.dart';
import '../util/color.dart';
import '../util/play_music.dart';
class CustomNavBar {
  static Future<Widget> navBar() async{
   await AudioPlayerSingleton.recentMusicList();
   return InkWell(
      onTap: (){
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
               await AudioPlayerSingleton.playSongs();
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
  // static recentMusicList()async {
  //   try {
  //     var recentSong= await RecentMusics.getRecentMusic();
  //     if(recentSong.songList!=null &&recentSong.songList!.isNotEmpty){
  //       selectedMusic=recentSong.songList??[];
  //       musicIndex=recentSong.currentMusicIndex??0;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
  // static Duration parseDuration(String timeString) {
  //     List<String> parts = timeString.split(':');
  //     if (parts.length == 3) {
  //       int hours = int.parse(parts[0]);
  //       int minutes = int.parse(parts[1]);
  //       int seconds = int.parse(parts[2]);
  //       return Duration(hours: hours, minutes: minutes, seconds: seconds);
  //     } else {
  //       throw const FormatException("Invalid time duration format");
  //     }
  //   }
  // static playSongs()async{
  //     try{
  //       if(AudioPlayerSingleton.audioPlayer.playing){
  //         AudioPlayerSingleton.audioPlayer.pause();
  //       }
  //       else{
  //         await AudioPlayerSingleton.audioPlayer.setUrl(selectedMusic?[musicIndex].uri??"",initialPosition:position.isNotEmpty?parseDuration(position):const Duration(seconds: 0));
  //         await AudioPlayerSingleton.audioPlayer.play();
  //       }
  //       var homeController=Get.put(HomeController());
  //       homeController.bottomNavBarWidget=await navBar();
  //       homeController.update();
  //     }catch(e){
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     }
  //   }
  // static playNextSong()async{
  //     try{
  //       await AudioPlayerSingleton.audioPlayer.pause();
  //       if (selectedMusic!=null &&musicIndex < selectedMusic!.length-1) {
  //         musicIndex++;
  //       }
  //       else {
  //         musicIndex = 0;
  //       }
  //       musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);
  //       position="";
  //       await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: selectedMusic,currentMusicIndex:musicIndex));
  //       var homeController=Get.put(HomeController());
  //       homeController.bottomNavBarWidget=await navBar();
  //       homeController.update();
  //       await playSongs();
  //     }catch(e){
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     }
  //   }
  // static playPreviousSong()async{
  //     try{
  //       await AudioPlayerSingleton.audioPlayer.pause();
  //       if (musicIndex > 0) {
  //         musicIndex--;
  //       }
  //       else {
  //         musicIndex = selectedMusic?.length??0 - 1;
  //       }
  //       musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);
  //
  //       await playSongs();
  //     }catch(e){
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     }
  //   }
}
