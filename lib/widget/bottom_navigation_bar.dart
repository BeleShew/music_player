import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bottom_navigation_bar_controller.dart';
import '../screen/music_player_page.dart';
import '../util/color.dart';
import '../util/play_music.dart';

class BottomNavBar extends StatelessWidget {
   BottomNavBar({super.key}){
     Get.delete<BottomNavBarController>(force: true);
     Get.put(BottomNavBarController());
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
        builder: (controllers) {
          return
            controllers.selectedMusic!=null&& controllers.selectedMusic!.isNotEmpty?
            InkWell(
            onTap: (){
              Get.to(()=>MusicPlayer(selectedMusic:controllers.selectedMusic??[],currentMusicIndex: controllers.musicIndex,isPlayMusic: false,));
            },
            child: Container(
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
                        Text(controllers.selectedMusic?[controllers.musicIndex].title??"",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(controllers.selectedMusic?[controllers.musicIndex].artist??""),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // AudioPlayerSingleton.playSongs();
                      controllers.playSongs();
                      controllers.update();
                    },
                      child:AudioPlayerSingleton.audioPlayer.playing?const Icon(Icons.pause_circle_outlined,size: 35,) : const Icon(Icons.play_circle_outline_rounded, size: 35,),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      // AudioPlayerSingleton.playNextSong();
                      controllers.playNextSong();
                      controllers.update();
                    },
                    child: const Icon(Icons.skip_next_rounded, size: 35,),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
          ):Container(height: 5,);
        });
  }
}
