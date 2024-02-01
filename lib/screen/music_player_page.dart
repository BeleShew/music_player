import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/music_player_controller.dart';
import 'package:music_player/widget/bottom_navigation_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../util/color.dart';
import '../util/play_music.dart';

typedef MusicPlayerCallBack = void Function(Widget currentMusicWidget);

class MusicPlayer extends StatelessWidget {
  MusicPlayer({required this.callBack, bool isAlreadyPlayMusic = false}) {
    // Get.delete<MusicPlayerController>(force: true);
    Get.put(MusicPlayerController(isAlreadyInPlay: isAlreadyPlayMusic));
  }

  MusicPlayerCallBack callBack;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicPlayerController>(builder: (logic) {
      return
        Scaffold(
          appBar: AppBar(
            leading: Transform.rotate(
              angle: pi / 2,
              child: InkWell(
                onTap: () async {
                  callBack(await CustomNavBar.navBar());
                  Get.back();
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2.6,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: QueryArtworkWidget(
                      artworkFit: BoxFit.fitWidth,
                      id: logic.selectedMusic[logic.musicIndex].id ?? 0,
                      // id: AudioPlayerSingleton.selectedMusic?[AudioPlayerSingleton.musicIndex].id ?? 0,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                RandomColors().getRandomColor(),
                                RandomColors().getRandomColor(),
                              ],
                            )
                        ),
                        child: const Icon(
                          Icons.music_note_sharp, size: 100,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30,),
                          Text(
                            // logic.selectedMusic[logic.musicIndex].title ?? "",
                            AudioPlayerSingleton
                                .selectedMusic?[AudioPlayerSingleton.musicIndex]
                                .title ?? "",
                            style: const TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AudioPlayerSingleton.position,
                                // logic.position,
                                style: const TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.normal),),

                              Slider(
                                min: const Duration(seconds: 0).inSeconds.toDouble(),
                                max: AudioPlayerSingleton.max,
                                // max: logic.max,
                                // value: logic.sliderValue,
                                value: AudioPlayerSingleton.sliderValue,
                                onChanged: (double value) {
                                  // logic.changeDurationToSecond(value.toInt());
                                  AudioPlayerSingleton.changeDurationToSecond(value.toInt());
                                  value = value.clamp(0, AudioPlayerSingleton.max);
                                  logic.update();
                                },
                              ),
                              Text(
                                // logic.duration,
                                AudioPlayerSingleton.duration,
                                style: const TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  logic.playPreviousSong();
                                  logic.update();
                                },
                                child: const Icon(
                                  Icons.skip_previous_rounded, size: 30,),
                              ),
                              InkWell(
                                onTap: () async {
                                  await logic.playSong();
                                  // AudioPlayerSingleton.playSongs(isNewMusic:true);
                                },
                                child: AudioPlayerSingleton.isPlaying
                                    ? const Icon(
                                  Icons.pause_circle_outlined,
                                  size: 40,)
                                    : const Icon(
                                  Icons.play_circle_outline, size: 40,),
                              ),
                              InkWell(
                                onTap: () async {
                                  logic.playNextSong();
                                  logic.update();
                                },
                                child: const Icon(
                                  Icons.skip_next_rounded, size: 30,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }
}
