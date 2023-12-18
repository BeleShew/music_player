import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/album_controller.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({super.key}){
    Get.put(AlbumController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumController>(
        builder: (controller) {
          return
            SingleChildScrollView(
            child: Container(
              child: Text('Album list'),
            ),
          );
        }
    );
  }
}
