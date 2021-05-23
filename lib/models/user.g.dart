// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    albumCount: json['album_count'] as int,
    bio: json['bio'] as String?,
    coverPhoto: json['cover_photo'] == null
        ? null
        : CoverPhoto.fromJson(json['cover_photo'] as Map<String, dynamic>),
    followeeCount: json['followee_count'] as int,
    followerCount: json['follower_count'] as int,
    handle: json['handle'] as String,
    id: json['id'] as String,
    isVerified: json['is_verified'] as bool,
    location: json['location'] as String?,
    name: json['name'] as String,
    playlistCount: json['playlist_count'] as int,
    profilePicture: json['profile_picture'] == null
        ? null
        : ProfilePicture.fromJson(
            json['profile_picture'] as Map<String, dynamic>),
    repostCount: json['repost_count'] as int,
    trackCount: json['track_count'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'album_count': instance.albumCount,
      'bio': instance.bio,
      'cover_photo': instance.coverPhoto?.toJson(),
      'followee_count': instance.followeeCount,
      'follower_count': instance.followerCount,
      'handle': instance.handle,
      'id': instance.id,
      'is_verified': instance.isVerified,
      'location': instance.location,
      'name': instance.name,
      'playlist_count': instance.playlistCount,
      'profile_picture': instance.profilePicture?.toJson(),
      'repost_count': instance.repostCount,
      'track_count': instance.trackCount,
    };
