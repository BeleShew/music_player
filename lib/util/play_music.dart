
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/controller/music_player_controller.dart';
import 'package:music_player/util/recent_music.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controller/home_controller.dart';
import '../model/songs_model.dart';
import '../widget/bottom_navigation_bar.dart';

class AudioPlayerSingleton extends GetxController {
  static final OnAudioQuery _onAudioQuery = OnAudioQuery();
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static AudioPlayer get audioPlayer => _audioPlayer;
  static OnAudioQuery get audioQuery => _onAudioQuery;

  static String duration="";
  static String position="";
  static List<SongList>? selectedMusic;
  static int  musicIndex=0;
  static bool isPlaying=false;
  static bool isRepeatEnabled=false;
  static double sliderValue = 0.0;
  static double max=0;

  static init()async {
    Get.delete<MusicPlayerController>(force: true);
    audioPlayer.durationStream.listen((event) {
      duration=event.toString().split(".")[0];
      max=event?.inSeconds.toDouble()??0;
    });
    audioPlayer.positionStream.listen((event)async{
      position=event.toString().split(".")[0];
      sliderValue=event.inSeconds.toDouble().clamp(0, max);
      if(isPlaying&& position==duration){
        isPlaying=false;
        await playNextSong();
      }
    });

    await recentMusicList();
  }
  static Duration parseDuration(String timeString) {
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
  static playSongs({bool isNewMusic=false})async{
    try{
      if(isNewMusic){
        max=0;
        duration="";
        position="";
        sliderValue=0;
        isPlaying=false;
      }
      if(audioPlayer.playing){
        audioPlayer.pause();
        isPlaying=false;
      }
      isPlaying=true;
      await audioPlayer.setUrl(selectedMusic?[musicIndex].uri??"",initialPosition:position.isNotEmpty?parseDuration(position):const Duration(seconds: 0));
      await audioPlayer.play();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static playNextSong()async{
    try{
      await audioPlayer.pause();
      if (selectedMusic!=null &&musicIndex < selectedMusic!.length-1) {
        musicIndex++;
      }
      else {
        musicIndex = 0;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);
      position="";
      max=0;
      duration="";
      sliderValue=0;
      await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: selectedMusic,currentMusicIndex:musicIndex));
      await updateBottomNavBar();
      await playSongs();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static playPreviousSong()async{
    try{
      await audioPlayer.pause();
      if (musicIndex > 0) {
        musicIndex--;
      }
      else {
        musicIndex = selectedMusic?.length??0 - 1;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic?.length??0-1);
      max=0;
      duration="";
      position="";
      sliderValue=0;
      await updateBottomNavBar();
      await playSongs();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static recentMusicList()async {
    try {
      var recentSong= await RecentMusics.getRecentMusic();
      if(recentSong.songList!=null &&recentSong.songList!.isNotEmpty){
        selectedMusic=recentSong.songList??[];
        musicIndex=recentSong.currentMusicIndex??0;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static updateBottomNavBar()async {
    var homeController=Get.put(HomeController());
    homeController.bottomNavBarWidget=await CustomNavBar.navBar();
    homeController.update();
  }
  static repeatMusic() async{
    try {
      max=0;
      duration="";
      position="";
      sliderValue=0;
      await playSongs();
      updateBottomNavBar();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static changeDurationToSecond(second){
    var durations=Duration(seconds: second);
    AudioPlayerSingleton.audioPlayer.seek(durations);
  }
  static resetPlayer() async{
    max=0;
    duration="";
    position="";
    sliderValue=0;
    isPlaying=false;
  }
}