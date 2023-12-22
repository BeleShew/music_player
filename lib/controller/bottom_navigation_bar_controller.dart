import 'package:get/get.dart';

import '../model/songs_model.dart';

class BottomNavBarController extends GetxController {
  int musicIndex=0;
  List<SongList>? selectedMusic;
  BottomNavBarController({required List<SongList> music,required int index}){
    musicIndex=index;
    selectedMusic=music;
    update();
  }
}