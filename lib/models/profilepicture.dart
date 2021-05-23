import 'package:json_annotation/json_annotation.dart';

part 'profilepicture.g.dart';

@JsonSerializable()
class ProfilePicture {
  ProfilePicture(
    this.p150x150,
    this.p480x480,
    this.p1000x1000,
  );

  final String? p150x150;
  final String? p480x480;
  final String? p1000x1000;

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => _$ProfilePictureFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}
