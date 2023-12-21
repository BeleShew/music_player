import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/songs_model.dart';
class ArtistDetailsController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  ArtistModel? artistModel;
  List<SongList> artistList=[];
  ArtistDetailsController(model){
    artistModel=model;
    selectArtistWithId();
    update();
  }
  selectArtistWithId()async{
    try{
      artistList=[];
      var selectedSongs= await _audioQuery.querySongs();
      if(selectedSongs.isNotEmpty){
        var filterSongs=selectedSongs.where((element) => element.artistId==artistModel?.id).toList();
        if(filterSongs.isNotEmpty){
          for (var element in filterSongs) {
            artistList.add(SongList()
              ..id=element.id
              ..genre=element.genre
              ..isAlarm=element.isAlarm
              ..isAudiobook=element.isAudioBook
              ..isMusic=element.isMusic
              ..isNotification=element.isNotification
              ..isPodcast=element.isPodcast
              ..isRingtone=element.isRingtone
              ..size=element.size
              ..title=element.title
              ..track=element.track
              ..uri=element.uri
              ..album=element.album
              ..albumArtist=element.artist
              ..albumId=element.albumId
              ..artist=element.artist
              ..data=element.data
              ..dateAdded=element.dateAdded
              ..dateModified=element.dateModified
              ..displayName=element.displayName
              ..displayNameWoExt=element.displayNameWOExt
              ..duration=element.duration
              ..fileExtension=element.fileExtension
              ..composer=element.composer);
          }
          // artistList=filterSongs;
        }
      }
      update();
    }catch(e){
      print(e);
    }
  }
}