import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<ArtistModel> artistList=[];
  @override
  void onInit() {
    super.onInit();
    getArtistList();
  }
  void getArtistList() async {
    try{
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){
        artistList = await _audioQuery.queryArtists(ignoreCase:true);
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