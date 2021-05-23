// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    artwork: json['artwork'] == null
        ? null
        : Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
    description: json['description'] as String?,
    genre: json['genre'] as String?,
    id: json['id'] as String,
    mood: json['mood'] as String?,
    releaseDate: json['release_date'] as String?,
    remixOf: json['remix_of'] as Map<String, dynamic>?,
    repostCount: json['repost_count'] as int,
    favoriteCount: json['favorite_count'] as int,
    tag: json['tag'] as String?,
    title: json['title'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    duration: Duration(microseconds: json['duration'] as int),
    downloadable: json['downloadable'] as bool?,
    playCount: json['play_count'] as int,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'artwork': instance.artwork?.toJson(),
      'description': instance.description,
      'genre': instance.genre,
      'id': instance.id,
      'mood': instance.mood,
      'release_date': instance.releaseDate,
      'remix_of': instance.remixOf,
      'repost_count': instance.repostCount,
      'favorite_count': instance.favoriteCount,
      'tag': instance.tag,
      'title': instance.title,
      'user': instance.user.toJson(),
      'duration': instance.duration.inMicroseconds,
      'downloadable': instance.downloadable,
      'play_count': instance.playCount,
    };
