import 'package:json_annotation/json_annotation.dart';

part 'coverphoto.g.dart';

@JsonSerializable()
class CoverPhoto {
  CoverPhoto({this.x640, this.x2000});

  @JsonKey(name: '640x')
  final String? x640;
  @JsonKey(name: '2000x')
  final String? x2000;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) =>
      _$CoverPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$CoverPhotoToJson(this);
}
