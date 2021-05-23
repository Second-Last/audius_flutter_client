import 'package:json_annotation/json_annotation.dart';

import 'user.dart';
import 'artwork.dart';

part 'playlist.g.dart';

/// A playlist, which is sometimes also referred to as
/// an album
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Playlist {
  final Artwork? artwork;
  final String? description;
  final int favoriteCount;
  final String id;
  final bool isAlbum;
  final String playlistName;
  final int repostCount;
  final int totalPlayCount;
  final User user;

  Playlist(
      {this.artwork,
      this.description,
      required this.favoriteCount,
      required this.id,
      required this.isAlbum,
      required this.playlistName,
      required this.repostCount,
      required this.totalPlayCount,
      required this.user});
  
  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
