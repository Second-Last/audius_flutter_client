import 'package:json_annotation/json_annotation.dart';

part 'coverphoto.g.dart';

@JsonSerializable()
class CoverPhoto {
  CoverPhoto({
    this.p640x,
    this.p2000x,
  });

  final String? p640x;
  final String? p2000x;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => _$CoverPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$CoverPhotoToJson(this);
}