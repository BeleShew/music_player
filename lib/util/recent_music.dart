import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:music_player/util/shared_preferences/shared_preferences.dart';
import '../model/songs_model.dart';
import 'constants.dart';

class RecentMusics{
  static saveRecentMusic({required RecentSongList recent}) async{
    try{
      String songStringList=json.encode(recent.toJson());
      await Sharedpreferences.saveValues(key: CatchConstantKeys.recentSongListKey,values: songStringList,valueTypeToSaved: PreferenceType.isString,isStringList:false);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  static Future<RecentSongList> getRecentMusic() async{
    try{
      RecentSongList songList=RecentSongList();
      await Sharedpreferences.initSharedPreference();
      var recentSong=await Sharedpreferences.getStringValuesSF(key: CatchConstantKeys.recentSongListKey);
      if(recentSong!=null){
        var decodedRecentSong= recentSongListFromJson(recentSong);
        if(decodedRecentSong.songList!=null &&decodedRecentSong.songList!.isNotEmpty){
          songList=decodedRecentSong;
        }
      }
      return songList;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return RecentSongList();
    }
  }
}