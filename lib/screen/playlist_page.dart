import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/playlist_controller.dart';

class PlayListPage extends StatelessWidget {
   PlayListPage({super.key}){
    Get.put(PlayListController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayListController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            child: Text('Play list'),
          ),
        );
      }
    );
  }
}
