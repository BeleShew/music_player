import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/music_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../model/songs_model.dart';
import '../util/color.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({super.key, required List<
      SongList> selectedMusic, required int currentMusicIndex}) {
    Get.delete<MusicPlayerController>(force: true);
    Get.put(MusicPlayerController(selectedMusic: selectedMusic, musicIndex: currentMusicIndex));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicPlayerController>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          leading: Transform.rotate(
            angle: pi / 2,
            child: InkWell(
              onTap: ()async {
               await logic.popUpMusicPlayer();
              },
              child: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:Column(
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
                          logic.selectedMusic[logic.musicIndex].title ?? "",
                          style: const TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        // Text(selectedMusic.artist??"",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(logic.position,
                              style: const TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.normal),),
                            Slider(
                              min: const Duration(seconds: 0).inSeconds
                                  .toDouble(),
                              max: logic.max,
                              value: logic.sliderValue,
                              onChanged: (double value) {
                                logic.changeDurationToSecond(value.toInt());
                                value = value.clamp(0, logic.max);
                                logic.update();
                              },
                            ),
                            Text(logic.duration,
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
                                await logic.playPreviousSong();
                              },
                              child: const Icon(
                                Icons.skip_previous_rounded, size: 30,),
                            ),
                            InkWell(
                              onTap: () async {
                                if (logic.isPlaying &&
                                    logic.position == logic.duration) {
                                  if (logic.isRepeatEnabled) {
                                    logic.repeatMusic();
                                    logic.update();
                                  }
                                  else {
                                    await logic.playNextSong();
                                  }
                                } else {
                                  logic.isPlaying = !logic.isPlaying;
                                  if (!logic.isPlaying) {
                                    logic.audioPlayer.pause();
                                  }
                                  else {
                                    logic.audioPlayer.play();
                                  }
                                }
                                logic.update();
                              },
                              child: (logic.isPlaying &&
                                  logic.position != logic.duration)
                                  ? const Icon(
                                Icons.pause_circle_outlined,
                                size: 40,)
                                  : const Icon(
                                Icons.play_circle_outline, size: 40,),
                            ),
                            InkWell(
                              onTap: () async {
                                await logic.playNextSong();
                              },
                              child: const Icon(
                                Icons.skip_next_rounded, size: 30,),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
