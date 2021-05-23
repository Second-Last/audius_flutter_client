// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist(
    artwork: json['artwork'] == null
        ? null
        : Artwork.fromJson(json['artwork'] as Map<String, dynamic>),
    description: json['description'] as String?,
    favoriteCount: json['favorite_count'] as int,
    id: json['id'] as String,
    isAlbum: json['is_album'] as bool,
    playlistName: json['playlist_name'] as String,
    repostCount: json['repost_count'] as int,
    totalPlayCount: json['total_play_count'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'artwork': instance.artwork?.toJson(),
      'description': instance.description,
      'favorite_count': instance.favoriteCount,
      'id': instance.id,
      'is_album': instance.isAlbum,
      'playlist_name': instance.playlistName,
      'repost_count': instance.repostCount,
      'total_play_count': instance.totalPlayCount,
      'user': instance.user.toJson(),
    };
