import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/songs_model.dart';

class AlbumDetailsController extends GetxController {
  AlbumModel? albumModel;
 List<SongList> songList=[];
 // List<SongModel> songList=[];
 final OnAudioQuery _audioQuery = OnAudioQuery();
  AlbumDetailsController(AlbumModel model){
    albumModel=model;
    selectAlbumWithId();
  }
 selectAlbumWithId()async{
   try{
     songList=[];
     var selectedSongs= await _audioQuery.querySongs();
     if(selectedSongs.isNotEmpty){
       var filterSongs=selectedSongs.where((element) => element.albumId==albumModel?.id).toList();
       if(filterSongs.isNotEmpty){
         for (var element in filterSongs) {
           songList.add(SongList()
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
       }
     }
     update();
   }catch(e){
     print(e);
   }
 }
}