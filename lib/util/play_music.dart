import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PlayAudioMusic{
  static playMusic({required String url}) async{
    try{
      final player = AudioPlayer();
      await player.setUrl(url);
      await player.play();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}