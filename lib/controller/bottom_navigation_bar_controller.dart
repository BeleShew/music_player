import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../model/songs_model.dart';
import '../util/play_music.dart';
import '../util/recent_music.dart';

class BottomNavBarController extends GetxController {
  int musicIndex=0;
  bool isPlaying=false;
  List<SongList>? selectedMusic;
  // late AudioPlayer audioPlayer;
  String duration="";
  String position="";
  BottomNavBarController(){
    recentMusicList();
    // audioPlayer=AudioPlayer();
    AudioPlayerSingleton.audioPlayer.durationStream.listen((event) {
      duration=event.toString().split(".")[0];
      update();
    });
    AudioPlayerSingleton.audioPlayer.positionStream.listen((event){
      position=event.toString().split(".")[0];
      if (isPlaying && position == duration){
        Future.delayed(const Duration(milliseconds: 200),()async{
          await playNextSong();
        });
      }
      update();
    });
    update();
  }
  recentMusicList()async {
    try {
      var recentSong= await RecentMusics.getRecentMusic();
      if(recentSong.songList!=null &&recentSong.songList!.isNotEmpty){
        selectedMusic=recentSong.songList??[];
        musicIndex=recentSong.currentMusicIndex??0;
      }
      update();
    } catch (e) {
      print(e);
    }
}
  Duration parseDuration(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length == 3) {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(parts[2]);
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } else {
      throw const FormatException("Invalid time duration format");
    }
  }
  playSongs()async{
    try{
      if(AudioPlayerSingleton.audioPlayer.playing){
        isPlaying=false;
        AudioPlayerSingleton.audioPlayer.pause();
      }else{
        isPlaying=true;
        await AudioPlayerSingleton.audioPlayer.setUrl(selectedMusic?[musicIndex].uri??"",initialPosition:position.isNotEmpty?parseDuration(position):const Duration(seconds: 0));
        await AudioPlayerSingleton.audioPlayer.play();
      }
      update();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playNextSong()async{
    try{
      await AudioPlayerSingleton.audioPlayer.pause();
      if (selectedMusic!=null &&musicIndex < selectedMusic!.length-1) {
        musicIndex++;
      }
      else {
        musicIndex = 0;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);
      position="";
      await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: selectedMusic,currentMusicIndex:musicIndex));
      await playSongs();
      update();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playPreviousSong()async{
    try{
      await AudioPlayerSingleton.audioPlayer.pause();
      if (musicIndex > 0) {
        musicIndex--;
      }
      else {
        musicIndex = selectedMusic?.length??0 - 1;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);

      await playSongs();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}