import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/services/network.dart';

import '../constants.dart';

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
      print('Trying to parse...');
      return ConcatenatingAudioSource(
          // children: mediaItems.map((mediaItem) => AudioSource.uri(mediaItem.extras!['stream'])).toList(),
          children: mediaItems.map((track) 
          {
        print(
            'https://${Network.host}/v1/tracks/${track.id}/stream?app_name=Audius+Flutter+Client');

        return AudioSource.uri(Uri.https(
          Network.host,
          'v1/tracks/${track.id}/stream',
          {'app_name': appName},
        ));
      })      // => AudioSource.uri(https.parse('https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3')))
.toList());

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
            duration: track.duration,
            artUri: Uri.parse(track.artwork?['1000x1000'] ??
                "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg")))
        .toList();
  }

  static ConcatenatingAudioSource track2AudioSource(List<Track> tracks) {
    return ConcatenatingAudioSource(
        children: tracks
            .map((track) => AudioSource.uri(Uri.parse(
                'https://dp01.audius.endl.net/v1/tracks/${track.id}/stream?app_name=EXAMPLEAPP')))
            .toList());
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
