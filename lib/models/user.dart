import 'package:flutter/foundation.dart';

// Confirm those initialized values
class User {
  User({
    @required this.albumCount,
    this.bio,
    this.coverPhoto,
    @required this.followeeCount,
    @required this.followerCount,
    @required this.handle,
    @required this.id,
    @required this.isVerified,
    this.location,
    @required this.name,
    @required this.playlistCount,
    this.profilePicture,
    @required this.repostCount,
    @required this.trackCount,
  });

  int albumCount = 0;
  String bio;
  CoverPhoto coverPhoto;
  int followeeCount = 0;
  int followerCount = 0;
  String handle;
  String id;
  bool isVerified = false;
  String location;
  String name;
  int playlistCount = 0;
  ProfilePicture profilePicture;
  int repostCount = 0;
  int trackCount = 0;
}

class CoverPhoto {
  CoverPhoto({
    this.p640x,
    this.p2000x,
  });

  final String p640x;
  final String p2000x;
}

class ProfilePicture {
  ProfilePicture({
    this.p150x150,
    this.p480x480,
    this.p1000x1000,
  });

  final String p150x150;
  final String p480x480;
  final String p1000x1000;
}