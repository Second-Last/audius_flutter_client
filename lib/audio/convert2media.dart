import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/models/track.dart';
import 'package:just_audio/just_audio.dart';

class Parsing {
  static List<Map<String, dynamic>> track2Map(List<Track> tracks) {
    try {
      return tracks
          .map((track) => {
                'id': track.id,
                'album': track.title,
                'title': track.title,
                'artist': track.user.name,
                'artUri': track.artwork?['1000x1000'] ??
                    "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg",
                'extras':
                    'https://dp01.audius.endl.net/v1/tracks/${track.id}/stream?app_name=EXAMPLEAPP'
              })
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  static List<MediaItem> map2MediaItem(List<Map<String, dynamic>> maps) {
    try {
      return maps
          .map((map) => MediaItem(
                id: map['id'],
                album: map['album'],
                title: map['title'],
                artist: map['artist'],
                artUri: Uri.parse(map['artUri']),
                extras: {'stream': Uri.parse(map['extras'])},
              ))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  static ConcatenatingAudioSource mediaItem2AudioSource(
      List<MediaItem> mediaItems) {
    try {
      return ConcatenatingAudioSource(
        // children: mediaItems.map((mediaItem) => AudioSource.uri(mediaItem.extras!['stream'])).toList(),
        children: mediaItems
            .map((item) => AudioSource.uri(Uri.parse(item.id)))
            .toList(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static List<MediaItem> track2MediaItem(List<Track> tracks) {
    return tracks
        .map((track) => MediaItem(
            id: track.id,
            album: track.title,
            title: track.title,
            artist: track.user.name,
            artUri: Uri.parse(track.artwork?['1000x1000'] ??
                "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg")))
        .toList();
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
