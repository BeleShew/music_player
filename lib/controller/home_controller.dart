import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/title_controller.dart';

import '../model/songs_model.dart';
import '../util/constants.dart';
import '../util/shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  ThemeMode themeMode =ThemeMode.dark;
  bool isDarkTheme=true;
  int musicIndex=0;
  List<SongList>? selectedMusic;
  Widget currentWidget=Get.put(TitleController()).homepage;
  HomeController(){
    recentMusicList();
  }
  updateThemeMode({required ThemeMode themeModes}){
    themeMode=themeModes;
    update();
  }
  recentMusicList()async {
    try {
      await Sharedpreferences.initSharedPreference();
      var recentSong=await Sharedpreferences.getStringValuesSF(key: CatchConstantKeys.recentSongListKey);
      if(recentSong!=null){
        var decodedRecentSong= recentSongListFromJson(recentSong);
        if(decodedRecentSong.songList!=null &&decodedRecentSong.songList!.isNotEmpty){
          selectedMusic=decodedRecentSong.songList??[];
          musicIndex=decodedRecentSong.currentMusicIndex??0;
        }
      }
      update();
    } catch (e) {
      print(e);
    }
}
}