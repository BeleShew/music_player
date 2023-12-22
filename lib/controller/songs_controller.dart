import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/util/shared_preferences/shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../model/songs_model.dart';
import '../util/constants.dart';

class SongsController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  SongsModel allSongs=SongsModel();
  SongsModel simplifiedSongs=SongsModel();
  bool isLoadAllData=false;
  final ScrollController scrollController = ScrollController();
  int itemsPerPage = 50;
  int loadedItems = 50;
   SongsController() {
    getSongList();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
@override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (loadedItems < allSongs.songList!.length) {
        int endIndex = loadedItems + itemsPerPage;
        if(endIndex<allSongs.songList!.length){
          simplifiedSongs.songList!.addAll(
            allSongs.songList!.sublist(loadedItems, endIndex),
          );
        }else{
          simplifiedSongs.songList!.addAll(
            allSongs.songList!.sublist(loadedItems, allSongs.songList!.length),
          );
        }
        loadedItems = endIndex;
      }
      update();
    }
  }


  void getSongList() async {
    try{
      isLoadAllData=false;
      var results= await _audioQuery.permissionsRequest(retryRequest: true);
      if(results){
        var catchSong= await Sharedpreferences.getStringListValuesSF(key:CatchConstantKeys.songListKey);
        if(catchSong!=null && catchSong.isNotEmpty){
          var decoded= await convertModelToJson(catchSong);
          if(decoded!=null){
            var model=SongsModel(expireDate: DateTime.now(),songList: decoded);
            allSongs=model;
          }
        }
        else{
          List<SongModel> songsList = await _audioQuery.querySongs(ignoreCase:true);
          if(songsList.isNotEmpty){
            List<SongList> songList=songsList.map((e) =>  SongList()..uri=e.uri
              ..artist=e.artist
              ..isAlarm=e.isAlarm
              ..isAudiobook=e.isAudioBook
              ..isMusic=e.isMusic
              ..title=e.title
              ..genre=e.genre
            // ..genreId=int.parse(e.genreId.toString())
              ..size=e.size
              ..duration=e.duration
              ..displayNameWoExt=e.displayNameWOExt
              ..displayName=e.displayName
              ..isNotification=e.isNotification
              ..track=e.track
              ..data=e.data
              ..dateAdded=e.dateAdded
              ..dateModified=e.dateModified
              ..album=e.album
              ..composer=e.composer
              ..isRingtone=e.isRingtone
              ..artistId=e.artistId
              ..isPodcast=e.isPodcast
              ..bookmark=e.bookmark
              ..albumId=e.albumId
              ..fileExtension=e.fileExtension
              ..id=e.id).toList();
            var tempString= await convertModelToString(songList);
            var model=SongsModel(expireDate: DateTime.now(),songList: songList);
            Sharedpreferences.saveValues(key: CatchConstantKeys.songListKey,values: tempString,valueTypeToSaved: PreferenceType.isString,isStringList:true);
            allSongs=model;
          }
        }
      }
      else{
        Get.snackbar("Permisson", "You don't have give permission");
      }
      simplifiedSongs=SongsModel(
        songList: allSongs.songList?.take(50).toList(),
        expireDate: allSongs.expireDate,
      );
      isLoadAllData=true;
      update();
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }
  }
  convertModelToString(List<SongList> model){
    try{
      List<String> tempModel=[];
      for (var element in model) {
        var  stringModel=json.encode(element.toJson());
        tempModel.add(stringModel);
      }
      return tempModel;
    }catch (e) {
      print(e);
    }
  }
  convertModelToJson(List<String> model){
    try{
      List<SongList> tempModel=[];
      for (var element in model) {
        var  stringModel=SongList.fromJson(json.decode(element));
        tempModel.add(stringModel);
      }
      return tempModel;
    }catch (e){
      print(e);
    }
  }
}