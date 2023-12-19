import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerController extends GetxController {
bool isPlaying=true;
double sliderValue = 0.0;
late OnAudioQuery audioQuery;
late AudioPlayer audioPlayer;
String duration="";
String position="";
double max=0;
  @override
  void onInit() {
    super.onInit();
    audioQuery=OnAudioQuery();
    audioPlayer=AudioPlayer();
    audioPlayer.durationStream.listen((event) {
      duration=event.toString().split(".")[0];
      max=event?.inSeconds.toDouble()??0;
      update();
    });
    audioPlayer.positionStream.listen((event) {
      position=event.toString().split(".")[0];
      sliderValue=event.inSeconds.toDouble().clamp(0, max);
      update();
    });
  }

  @override
  void onClose(){
    audioPlayer.dispose();
    audioPlayer.stop();
  }
  repeatMusic(url) async{
    max=0;
    duration="";
    position="";
    sliderValue=0;
    isPlaying=true;
   await playSongs(url);
   update();
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
}