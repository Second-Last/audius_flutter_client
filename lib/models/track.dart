import 'package:audius_flutter_client/models/user.dart';

class Track {
  final Map<String, dynamic>? artwork;
  final String? description;
  final String? genre;
  final String id;
  final String? mood;
  final String? releaseDate;
  final Map<String, dynamic>? remixOf;
  final int repostCount;
  final int favoriteCount;
  final String? tag;
  final String title;
  final Map<String, dynamic> rawUser;
  late final User user = User.fromJson(rawUser);
  final Duration duration;
  final bool? downloadable;
  final int playCount;

  Track(
      {this.artwork,
      this.description,
      this.genre,
      required this.id,
      this.mood,
      this.releaseDate,
      this.remixOf,
      required this.repostCount,
      required this.favoriteCount,
      this.tag,
      required this.title,
      required this.rawUser,
      required this.duration,
      this.downloadable,
      required this.playCount});

  Track.fromJson(Map<String, dynamic> json)
      : artwork = json['artwork'],
        description = json['description'],
        genre = json['genre'],
        id = json['id'],
        mood = json['mood'],
        releaseDate = json['release_date'],
        remixOf = json['release_of'],
        repostCount = json['repost_count'],
        favoriteCount = json['favorite_count'],
        tag = json['tag'],
        title = json['title'],
        rawUser = json['user'],
        duration = Duration(seconds: json['duration']),
        downloadable = json['downloadable'],
        playCount = json['play_count'];
}
