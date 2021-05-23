// import 'package:flutter/foundation.dart';
// import 'package:json_annotation/json_annotation.dart';


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
  // @JsonKey(required: true)
  int albumCount = 0;
  // @JsonKey(defaultValue: false)
  String? bio;
  // @JsonKey(defaultValue: false)
  Map? coverPhoto;
  int followeeCount = 0;
  int followerCount = 0;
  String handle;
  String id;
  bool isVerified = false;
  // @JsonKey(defaultValue: false)
  String? location;
  String name;
  int playlistCount = 0;
  // @JsonKey(defaultValue: false)
  Map? profilePicture;
  int repostCount = 0;
  int trackCount = 0;

}

class CoverPhoto {
  CoverPhoto.fromJson({
    this.p640x,
    this.p2000x,
  });

  final String? p640x;
  final String? p2000x;
}

class ProfilePicture {
  ProfilePicture({
    this.p150x150,
    this.p480x480,
    this.p1000x1000,
  });

  final String? p150x150;
  final String? p480x480;
  final String? p1000x1000;
}

// Do I actually need this????
class UserResponse {
  UserResponse(this.user);

  User user;
}