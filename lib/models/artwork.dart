import 'package:json_annotation/json_annotation.dart';

part 'artwork.g.dart';

/// We don't differentiate between TrackArtwork and PlaylistArtwork
@JsonSerializable()
class Artwork {
  Artwork({this.x150, this.x480, this.x1000});

  @JsonKey(name: '150x150')
  final String? x150;
  @JsonKey(name: '480x480')
  final String? x480;
  @JsonKey(name: '1000x1000')
  final String? x1000;

  factory Artwork.fromJson(Map<String, dynamic> json) => _$ArtworkFromJson(json);
  Map<String, dynamic> toJson() => _$ArtworkToJson(this);
}
