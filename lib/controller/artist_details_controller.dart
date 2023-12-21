import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
class ArtistDetailsController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  ArtistModel? artistModel;
  List<SongModel> artistList=[];
  ArtistDetailsController(model){
    artistModel=model;
    selectArtistWithId();
    update();
  }
  selectArtistWithId()async{
    try{
      var selectedSongs= await _audioQuery.querySongs();
      if(selectedSongs.isNotEmpty){
        var filterSongs=selectedSongs.where((element) => element.artistId==artistModel?.id).toList();
        if(filterSongs.isNotEmpty){
          artistList=filterSongs;
        }
      }
      update();
    }catch(e){
      print(e);
    }
  }
}