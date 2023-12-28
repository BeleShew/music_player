
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerSingleton {
  static final OnAudioQuery _onAudioQuery = OnAudioQuery();
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static AudioPlayer get audioPlayer => _audioPlayer;
  static OnAudioQuery get audioQuery => _onAudioQuery;

  // static String duration="";
  // static String position="";
  // static List<SongList>? musicList;
  // static int  musicIndex=0;
  // static init(){
  //   audioPlayer.durationStream.listen((event) {
  //     duration=event.toString().split(".")[0];
  //   });
  //   audioPlayer.positionStream.listen((event){
  //     position=event.toString().split(".")[0];
  //     if(audioPlayer.playing&& position==duration){
  //       Future.delayed(const Duration(milliseconds: 200),()async{
  //         await playNextSong();
  //       });
  //     }
  //   });
  // }
  // static playSongs()async{
  //   try{
  //     if(audioPlayer.playing){
  //       audioPlayer.pause();
  //     }else{
  //       await AudioPlayerSingleton.audioPlayer.setUrl(musicList?[musicIndex].uri??"",initialPosition:position.isNotEmpty?_parseDuration(position):const Duration(seconds: 0));
  //       await AudioPlayerSingleton.audioPlayer.play();
  //     }
  //   }catch(e){
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
  // static playNextSong()async{
  //   try{
  //     await AudioPlayerSingleton.audioPlayer.pause();
  //     if (musicList!=null &&musicIndex < musicList!.length-1) {
  //       musicIndex++;
  //     }
  //     else {
  //       musicIndex = 0;
  //     }
  //     musicIndex=musicIndex.clamp(0, musicList?.length??0-1);
  //     position="";
  //     await RecentMusics.saveRecentMusic(recent: RecentSongList(songList: musicList,currentMusicIndex:musicIndex));
  //     var updatenavBar= Get.find<BottomNavBarController>();
  //     updatenavBar.recentMusicList();
  //     await playSongs();
  //   }catch(e){
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
  // static playPreviousSong()async{
  //   try{
  //     await AudioPlayerSingleton.audioPlayer.pause();
  //     if (musicIndex > 0) {
  //       musicIndex--;
  //     }
  //     else {
  //       musicIndex = musicList?.length??0 - 1;
  //     }
  //     musicIndex=musicIndex.clamp(0, musicList?.length??0-1);
  //     position="";
  //     await playSongs();
  //   }catch(e){
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }
  // static Duration _parseDuration(String timeString) {
  //   List<String> parts = timeString.split(':');
  //   if (parts.length == 3) {
  //     int hours = int.parse(parts[0]);
  //     int minutes = int.parse(parts[1]);
  //     int seconds = int.parse(parts[2]);
  //     return Duration(hours: hours, minutes: minutes, seconds: seconds);
  //   } else {
  //     throw const FormatException("Invalid time duration format");
  //   }
  // }
  // static isMusicplaying(){
  //   return audioPlayer.playing;
  // }
}