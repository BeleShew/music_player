import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_player/util/play_music.dart';
import '../model/songs_model.dart';
import '../util/recent_music.dart';
import '../widget/bottom_navigation_bar.dart';

class MusicPlayerController extends GetxController {
bool isPlaying=false;
bool isRepeatEnabled=false;
double sliderValue = 0.0;
String duration="";
String position="";
double max=0;
int musicIndex=AudioPlayerSingleton.musicIndex;
List<SongList> selectedMusic=AudioPlayerSingleton.selectedMusic??[];
MusicPlayerController({bool isAlreadyInPlay=false}) {
  try {
    if(!isAlreadyInPlay){
      AudioPlayerSingleton.playSongs(isNewMusic:true);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

  @override
  void onClose(){
    // AudioPlayerSingleton.audioPlayer.dispose();
    // AudioPlayerSingleton.audioPlayer.stop();
  }
  playSong() async{
    try {
      if(AudioPlayerSingleton.isPlaying){
         AudioPlayerSingleton.audioPlayer.pause();
        AudioPlayerSingleton.isPlaying=false;
      }
      else{
        AudioPlayerSingleton.playSongs(isNewMusic:false);
      }
      await AudioPlayerSingleton.updateBottomNavBar();
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playNextSong()async{
    try{
      // if(AudioPlayerSingleton.isPlaying){
      //   await AudioPlayerSingleton.audioPlayer.pause();
      // }
      if (musicIndex < selectedMusic.length-1) {
        musicIndex++;
      }
      else {
        musicIndex = 0;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic.length-1);
      AudioPlayerSingleton.selectedMusic=selectedMusic;
      AudioPlayerSingleton.musicIndex=musicIndex;
      await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: selectedMusic,currentMusicIndex:musicIndex));
      await AudioPlayerSingleton.updateBottomNavBar();
      await AudioPlayerSingleton.playSongs();
      update();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playPreviousSong()async{
  try{
    // if(AudioPlayerSingleton.isPlaying){
    //   await AudioPlayerSingleton.audioPlayer.pause();
    // }
    if (musicIndex > 0) {
      musicIndex--;
    }
    else {
      musicIndex = selectedMusic.length - 1;
    }
    musicIndex=musicIndex.clamp(0, selectedMusic.length-1);
    AudioPlayerSingleton.selectedMusic=selectedMusic;
    AudioPlayerSingleton.musicIndex=musicIndex;
    await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: selectedMusic,currentMusicIndex:musicIndex));
    // await AudioPlayerSingleton.recentMusicList();
    await AudioPlayerSingleton.updateBottomNavBar();
    await AudioPlayerSingleton.playSongs();
    update();
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
}
  changeDurationToSecond(second){
    var durations=Duration(seconds: second);
    AudioPlayerSingleton.audioPlayer.seek(durations);
    update();
  }
}