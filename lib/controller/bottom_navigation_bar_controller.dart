import 'package:get/get.dart';

import '../model/songs_model.dart';

class BottomNavBarController extends GetxController {
  int musicIndex=0;
  List<SongList> selectedMusic;
  BottomNavBarController({required this.selectedMusic,required this.musicIndex}){

  }
}