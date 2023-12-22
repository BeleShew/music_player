import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/controller/home_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/songs_model.dart';
import '../util/constants.dart';
import '../util/shared_preferences/shared_preferences.dart';

class MusicPlayerController extends GetxController {
bool isPlaying=true;
bool isRepeatEnabled=false;
double sliderValue = 0.0;
late OnAudioQuery audioQuery;
late AudioPlayer audioPlayer;
String duration="";
String position="";
double max=0;
int musicIndex=0;
List<SongList> selectedMusic;
MusicPlayerController({required this.selectedMusic,required this.musicIndex}) {
  try {
    audioQuery=OnAudioQuery();
    audioPlayer=AudioPlayer();
    audioPlayer.durationStream.listen((event) {
      duration=event.toString().split(".")[0];
      max=event?.inSeconds.toDouble()??0;
      update();
    });
    audioPlayer.positionStream.listen((event){
      position=event.toString().split(".")[0];
      sliderValue=event.inSeconds.toDouble().clamp(0, max);
      if (isPlaying && position == duration){
        Future.delayed(const Duration(milliseconds: 200),()async{
          await playNextSong();
        });
      }
      update();
    });
    playSongs(selectedMusic[musicIndex].uri);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

  @override
  void onClose(){
    audioPlayer.dispose();
    audioPlayer.stop();
  }
  repeatMusic() async{
    try {
      max=0;
      duration="";
      position="";
      sliderValue=0;
      isPlaying=true;
      await playSongs(selectedMusic[musicIndex].uri);
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playNextSong()async{
    try{
      await audioPlayer.pause();
      if (musicIndex < selectedMusic.length-1) {
        musicIndex++;
      }
      else {
        musicIndex = 0;
      }
      musicIndex=musicIndex.clamp(0, selectedMusic.length-1);
      max=0;
      duration="";
      position="";
      sliderValue=0;
      isPlaying=true;
      await playSongs(selectedMusic[musicIndex].uri);
      update();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  playPreviousSong()async{
  try{
    await audioPlayer.pause();
    if (musicIndex > 0) {
      musicIndex--;
    }
    else {
      musicIndex = selectedMusic.length - 1;
    }
    musicIndex=musicIndex.clamp(0, selectedMusic.length-1);
    max=0;
    duration="";
    position="";
    sliderValue=0;
    isPlaying=true;
    await playSongs(selectedMusic[musicIndex].uri);
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
  }
}
  changeDurationToSecond(second){
    var durations=Duration(seconds: second);
    audioPlayer.seek(durations);
    update();
  }
  playSongs(url)async{
    try{
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  popUpMusicPlayer()async{
    try {
      RecentSongList recentSongList=RecentSongList()
        ..currentMusicIndex=musicIndex
        ..songList=selectedMusic;
      String songStringList=json.encode(recentSongList.toJson());
      await Sharedpreferences.saveValues(key: CatchConstantKeys.recentSongListKey,values: songStringList,valueTypeToSaved: PreferenceType.isString,isStringList:false);

      var updateHomeController=Get.find<HomeController>();
      updateHomeController.musicIndex=musicIndex;
      updateHomeController.selectedMusic=selectedMusic;
      updateHomeController.update();

      Get.back();
      update();
    } catch (e) {
      print(e);
    }
  }
}