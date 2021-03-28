import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/models/track.dart';

List<Map<String, dynamic>> track2Map(List<Track> tracks) {
  try {
    return tracks
        .map((track) => {
              'id': track.id,
              'album': track.title,
              'title': track.title,
              'artist': track.user.name,
              'artUri': track.artwork?['1000x1000'] ?? 'none',
              'extras': 'https://discoveryprovider.audius3.prod-us-west-2.staked.cloud/v1/tracks/${track.id}/stream?app_name=EXAMPLEAPP'
            })
        .toList();
  } catch (e) {
    throw Exception(e);
  }
}

List<MediaItem> map2MediaItem(List<Map<String, dynamic>> maps) {
  try {
    return maps.map((map) => MediaItem(
      id: map['id'],
      album: map['album'],
      title: map['title'],
      artist: map['artist'],
      artUri: Uri.parse(map['artUri']),
      extras: {'stream': Uri.parse(map['extras'])},
    )).toList();
  } catch (e) {
    throw Exception(e);
  }
}
// class AudioMetadata {
//   final String album;
//   final String title;
//   final String artwork;
//   final String artist;

//   AudioMetadata(
//       {required this.album, required this.title, required this.artwork, required this.artist});
// }
