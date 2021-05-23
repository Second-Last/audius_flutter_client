// import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'profilepicture.dart';
import 'coverphoto.dart';

// Confirm those initialized values
class User {
  User({
    required this.albumCount,
    this.bio,
    this.coverPhoto,
    required this.followeeCount,
    required this.followerCount,
    required this.handle,
    required this.id,
    required this.isVerified,
    this.location,
    required this.name,
    required this.playlistCount,
    this.profilePicture,
    required this.repostCount,
    required this.trackCount,
  });

  // User.fromJson(Map<String, dynamic> json)
  //   : albumCount = json['album_count'],
  //     bio = json['bio'],
  //     coverPhoto = json['coverPhoto'],
  //     followeeCount = json['followee_count'],
  //     followerCount = json['follower_count'],
  //     handle = json['handle'],
  //     id = json['id'],
  //     isVerified = json['is_verified'],
  //     location = json['location'],
  //     name = json['name'],
  //     playlistCount = json['playlist_count'],
  //     profilePicture = json['profile_picture'],
  //     repostCount = json['repost_count'],
  //     trackCount = json['track_count'];

  // TODO: do I need final here?
  @JsonKey(required: true)
  int albumCount = 0;
  @JsonKey(defaultValue: false)
  String? bio;
  @JsonKey(defaultValue: false)
  CoverPhoto coverPhoto;
  int followeeCount = 0;
  int followerCount = 0;
  String handle;
  String id;
  bool isVerified = false;
  @JsonKey(defaultValue: false)
  String? location;
  String name;
  int playlistCount = 0;
  @JsonKey(defaultValue: false)
  ProfilePicture profilePicture;
  int repostCount = 0;
  int trackCount = 0;
}