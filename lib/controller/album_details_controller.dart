import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumDetailsController extends GetxController {
  AlbumModel? albumModel;
 List<SongModel> songList=[];
 final OnAudioQuery _audioQuery = OnAudioQuery();
  AlbumDetailsController(AlbumModel model){
    albumModel=model;
    selectAlbumWithId();
  }
 selectAlbumWithId()async{
   try{
     var selectedSongs= await _audioQuery.querySongs();
     if(selectedSongs.isNotEmpty){
       var filterSongs=selectedSongs.where((element) => element.albumId==albumModel?.id).toList();
       if(filterSongs.isNotEmpty){
         songList=filterSongs;
       }
     }
     update();
   }catch(e){
     print(e);
   }
 }
}