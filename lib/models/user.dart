// import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'profilepicture.dart';
import 'coverphoto.dart';

part 'user.g.dart';

// Confirm those initialized values
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
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

  int albumCount = 0;
  final String? bio;
  final CoverPhoto? coverPhoto;
  int followeeCount = 0;
  int followerCount = 0;
  final String handle;
  final String id;
  bool isVerified = false;
  final String? location;
  final String name;
  int playlistCount = 0;
  final ProfilePicture? profilePicture;
  int repostCount = 0;
  int trackCount = 0;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
