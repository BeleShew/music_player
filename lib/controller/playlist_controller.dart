import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<PlaylistModel> playList=[];
 @override
  void onInit() {
    super.onInit();
    getPlayList();
  }
  void getPlayList() async {
    try{
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){
        playList = await _audioQuery.queryPlaylists();
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
}