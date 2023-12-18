import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  AlbumController(){
    getFiles();
  }
  void getFiles() async {
    try{
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){

      }
      List<AlbumModel> albums = await _audioQuery.queryAlbums();
      if(albums.isNotEmpty){
      }
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }
  }
}