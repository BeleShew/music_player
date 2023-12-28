import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

class AudioPlayerSingleton {
  static final OnAudioQuery _onAudioQuery = OnAudioQuery();
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static AudioPlayer get audioPlayer => _audioPlayer;
  static OnAudioQuery get audioQuery => _onAudioQuery;
}