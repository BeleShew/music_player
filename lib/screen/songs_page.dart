import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/playlist_controller.dart';

import '../controller/songs_controller.dart';

class SongsPage extends StatelessWidget {
  SongsPage({super.key}){
    Get.put(SongsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SongsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              child: Text('Songs list'),
            ),
          );
        }
    );
  }
}
