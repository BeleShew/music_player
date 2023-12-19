import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> songList=[];
  // SongsController(){
  //   getSongList();
  // }
  @override
  void onInit() {
    super.onInit();
    getSongList();
  }
  void getSongList() async {
    try{
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){
        songList = await _audioQuery.querySongs();
      }else{
        Get.snackbar("Permisson", "You don't have give permission");
      }
      update();
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }
  }
  playMusic(){
    try{
      
    }catch(e){
      print(e);
    }
  }
}