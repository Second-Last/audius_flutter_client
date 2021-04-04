import 'package:flutter_test/flutter_test.dart';

import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/audio/convert2media.dart';

void main() {
  List<Track> tracks = [
    Track(
      id: '12345',
      title: 'Lorem Ipsum',
      repostCount: 666665,
      favoriteCount: 23333,
      playCount: 112358,
      duration: Duration(seconds: 60),
      rawUser: {
        "album_count": 0,
        "bio": "string",
        "cover_photo": {"640x": "string", "2000x": "string"},
        "followee_count": 0,
        "follower_count": 0,
        "handle": "string",
        "id": "string",
        "is_verified": true,
        "location": "string",
        "name": "string",
        "playlist_count": 0,
        "profile_picture": {
          "150x150": "string",
          "480x480": "string",
          "1000x1000": "string"
        },
        "repost_count": 0,
        "track_count": 0
      },
    ),
  ];

  group('Parsing tests:', () {
    List<Map<String, dynamic>> maps = Parsing.track2Map(tracks);
    test('track2Map test', () => expect(maps[0]['id'], '12345'));

    List<MediaItem> mediaItems = Parsing.map2MediaItem(maps);
    test('map2MediaItem test', () {
      expect(mediaItems[0].artist, 'string');
      expect(
          mediaItems[0].extras!['stream'],
          Uri.parse(
              'https://dp01.audius.endl.net/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP'));
    });

    List<MediaItem> audioSource = <MediaItem>[
      MediaItem(
        // This can be any unique id, but we use the audio URL for convenience.
        id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artist: "Science Friday and WNYC Studios",
        duration: Duration(milliseconds: 5739820),
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
      MediaItem(
        id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artist: "Science Friday and WNYC Studios",
        duration: Duration(milliseconds: 2856950),
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ];

    ConcatenatingAudioSource concatenatingAudioSource =
        ConcatenatingAudioSource(
      children: audioSource
          .map((item) => AudioSource.uri(Uri.parse(item.id)))
          .toList(),
    );

    test('mediaItem2ConcatenatingAudioSource test', () {
      expect(
        ConcatenatingAudioSource(
          children: audioSource
              .map((item) => AudioSource.uri(Uri.parse(item.id)))
              .toList(),
        ),
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse(
              'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3')),
          AudioSource.uri(Uri.parse(
              "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3")),
        ]),
      );
    });

    test('direct map2ConcatenatingAudioSource test', () {
      expect(
        ConcatenatingAudioSource(
            children: List.of(Parsing.map2MediaItem(maps)
                .map(
                    (mediaItem) => AudioSource.uri(mediaItem.extras!['stream']))
                .toList())),
        ConcatenatingAudioSource(children: [
          AudioSource.uri(Uri.parse(
              'https://dp01.audius.endl.net/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP'))
        ]),
      );
    });
  });
}
