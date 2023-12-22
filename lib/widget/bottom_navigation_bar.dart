import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/music_player_controller.dart';
import '../controller/bottom_navigation_bar_controller.dart';
import '../model/songs_model.dart';
import '../util/color.dart';

class BottomNavBar extends StatelessWidget {
   BottomNavBar({super.key,required List<SongList> selectedMusic,required int musicIndex}){
     Get.delete<BottomNavBarController>(force: true);
     Get.put(BottomNavBarController(music: selectedMusic,index: musicIndex));
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BottomNavBarController>(
        builder: (controllers) {
          var playMusic= Get.put(MusicPlayerController(selectedMusic:controllers.selectedMusic??[],musicIndex: controllers.musicIndex ));
          return Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  RandomColors().getRandomColor(),
                  RandomColors().getRandomColor()
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(30)
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.music_note_rounded, size: 35,),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(controllers.selectedMusic?[controllers.musicIndex].album??"",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(controllers.selectedMusic?[controllers.musicIndex].artist??""),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                   playMusic.playSongs(controllers.selectedMusic?[controllers.musicIndex].uri);
                  },
                    child: const Icon(Icons.play_circle_outline_rounded, size: 35,),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    playMusic.musicIndex=controllers.musicIndex;
                    playMusic.selectedMusic=controllers.selectedMusic??[];
                    playMusic.playNextSong();
                    playMusic.update();
                  },
                  child: const Icon(Icons.skip_next_rounded, size: 35,),
                ),
                const SizedBox(width: 10,),
              ],
            ),
          );
        });
  }
}
