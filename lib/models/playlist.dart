import 'package:audius_flutter_client/models/user.dart';

/// A playlist, which is sometimes also referred to as
/// an album
class Playlist {
  final Map<String, dynamic>? artwork;
  final String? description;
  final int favoriteCount;
  final String id;
  final bool isAlbum;
  final String playlistName;
  final int repostCount;
  final int totalPlayCount;
  final Map<String, dynamic> rawUser;
  late final User user = User.fromJson(rawUser);

  Playlist(
      {this.artwork,
      this.description,
      required this.favoriteCount,
      required this.id,
      required this.isAlbum,
      required this.playlistName,
      required this.repostCount,
      required this.totalPlayCount,
      required this.rawUser});

  Playlist.fromJson(Map<String, dynamic> json)
      : artwork = json['artwork'],
        description = json['description'],
        id = json['id'],
        isAlbum = json['is_album'],
        playlistName = json['playlist_name'],
        repostCount = json['repost_count'],
        favoriteCount = json['favorite_count'],
        totalPlayCount = json['total_play_count'],
        rawUser = json['user'];
}
