import 'package:get/get.dart';
import 'package:music_player/controller/album_controller.dart';
import 'package:music_player/controller/artist_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import '../controller/songs_controller.dart';

class ControllerInit{
  ControllerInit(){
    Get.lazyPut(()=>SongsController(),fenix: true);
    Get.lazyPut(()=>PlayListController(),fenix: true);
    Get.lazyPut(()=>AlbumController(),fenix: true);
    Get.lazyPut(()=>ArtistController(),fenix: true);
  }
}