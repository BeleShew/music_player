
import 'dart:convert';
SongsModel songsModelFromJson(String str) => SongsModel.fromJson(json.decode(str));
String songsModelToJson(SongsModel data) => json.encode(data.toJson());
class SongsModel {
  List<SongList>? songList;
  DateTime? expireDate;
  SongsModel({
    this.songList,
    this.expireDate,
  });

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
    songList: json["songList"] == null ? [] : List<SongList>.from(json["songList"]!.map((x) => SongList.fromJson(x))),
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
  );

  Map<String, dynamic> toJson() => {
    "songList": songList == null ? [] : List<dynamic>.from(songList!.map((x) => x.toJson())),
    "expireDate": expireDate?.toIso8601String(),
  };
}
class SongList {
  String? uri;
  String? artist;
  String? year;
  bool? isMusic;
  String? title;
  int? genreId;
  int? size;
  int? duration;
  bool? isAlarm;
  String? displayNameWoExt;
  String? albumArtist;
  String? genre;
  bool? isNotification;
  int? track;
  String? data;
  String? displayName;
  String? album;
  String? composer;
  bool? isRingtone;
  int? artistId;
  bool? isPodcast;
  int? bookmark;
  int? dateAdded;
  bool? isAudiobook;
  int? dateModified;
  int? albumId;
  String? fileExtension;
  int? id;

  SongList({
    this.uri,
    this.artist,
    this.year,
    this.isMusic,
    this.title,
    this.genreId,
    this.size,
    this.duration,
    this.isAlarm,
    this.displayNameWoExt,
    this.albumArtist,
    this.genre,
    this.isNotification,
    this.track,
    this.data,
    this.displayName,
    this.album,
    this.composer,
    this.isRingtone,
    this.artistId,
    this.isPodcast,
    this.bookmark,
    this.dateAdded,
    this.isAudiobook,
    this.dateModified,
    this.albumId,
    this.fileExtension,
    this.id,
  });

  factory SongList.fromJson(Map<String, dynamic> json) => SongList(
    uri: json["_uri"],
    artist: json["artist"],
    year: json["year"],
    isMusic: json["is_music"],
    title: json["title"],
    genreId: json["genre_id"],
    size: json["_size"],
    duration: json["duration"],
    isAlarm: json["is_alarm"],
    displayNameWoExt: json["_display_name_wo_ext"],
    albumArtist: json["album_artist"],
    genre: json["genre"],
    isNotification: json["is_notification"],
    track: json["track"],
    data: json["_data"],
    displayName: json["_display_name"],
    album: json["album"],
    composer: json["composer"],
    isRingtone: json["is_ringtone"],
    artistId: json["artist_id"],
    isPodcast: json["is_podcast"],
    bookmark: json["bookmark"],
    dateAdded: json["date_added"],
    isAudiobook: json["is_audiobook"],
    dateModified: json["date_modified"],
    albumId: json["album_id"],
    fileExtension: json["file_extension"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_uri": uri,
    "artist": artist,
    "year": year,
    "is_music": isMusic,
    "title": title,
    "genre_id": genreId,
    "_size": size,
    "duration": duration,
    "is_alarm": isAlarm,
    "_display_name_wo_ext": displayNameWoExt,
    "album_artist": albumArtist,
    "genre": genre,
    "is_notification": isNotification,
    "track": track,
    "_data": data,
    "_display_name": displayName,
    "album": album,
    "composer": composer,
    "is_ringtone": isRingtone,
    "artist_id": artistId,
    "is_podcast": isPodcast,
    "bookmark": bookmark,
    "date_added": dateAdded,
    "is_audiobook": isAudiobook,
    "date_modified": dateModified,
    "album_id": albumId,
    "file_extension": fileExtension,
    "_id": id,
  };
}
