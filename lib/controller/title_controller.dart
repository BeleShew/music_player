import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/screen/album_page.dart';
import 'package:music_player/screen/playlist_page.dart';
import 'package:music_player/screen/songs_page.dart';
import '../util/constants.dart';

class TitleController extends GetxController {
  int selectedIndex = 0;
  List<Widget> titleList=[];
  Widget homepage=Container();
  List<String> titleString=["Playlists","Songs","Albums"];
  TitleController(){
    buildSelectedHomePage();
    buildTitleWidget();
  }
  buildTitleWidget(){
    titleList=[];
    int indexs=0;
    for (var element in titleString) {
      titleList.add(
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: selectedIndex == indexs ? Keys.title2 : Keys.title4,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Center(
              child: Text(element,style: TextStyle(
                color: selectedIndex == indexs ? Keys.textBlackColor : Keys.textWhiteColor,
              ),),
            ),
          ),
        )
      );
      indexs+=1;
    }
    update();
  }
  buildSelectedHomePage(){
    if(selectedIndex==0){
      homepage=PlayListPage();
    }
    else if(selectedIndex==1){
      homepage=SongsPage();
    }
    else if(selectedIndex==2){
      homepage=AlbumPage();
    }
    else{

    }
    update();
  }
}