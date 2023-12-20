import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<AlbumModel> albums=[];
@override
  void onInit() async{
    super.onInit();
    getAlbumList();
  }
  void getAlbumList() async {
    try{
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){
        albums = await _audioQuery.queryAlbums(ignoreCase:true);
      }
      else{
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