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
    test(
        'track2Map test',
        () => expect(
              maps,
              [
                {
                  'id': '12345',
                  'title': 'Lorem Ipsum',
                  'album': 'Lorem Ipsum',
                  'artist': 'string',
                  'artUri':
                      "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg",
                  'extras':
                      'https://dp01.audius.endl.net/v1/tracks/12345/stream?app_name=EXAMPLEAPP',
                }
              ],
            ));

    test(
      'track2MediaItem test',
      () => expect(
        Parsing.track2MediaItem(tracks),
        [
          MediaItem(
            id: '12345',
            album: 'Lorem Ipsum',
            title: 'Lorem Ipsum',
            artist: 'string',
            artUri: Uri.parse(
                "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg"),
          )
        ],
      ),
    );

    List<MediaItem> mediaItems = Parsing.map2MediaItem(maps);
    test('map2MediaItem test', () {
      expect(mediaItems[0].artist, 'string');
      expect(
          mediaItems[0].extras!['stream'],
          Uri.parse(
              'https://dp01.audius.endl.net/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP'));
      expect(mediaItems, [
        MediaItem(
            id: '12345',
            album: 'Lorem Ipsum',
            title: 'Lorem Ipsum',
            artist: 'string',
            artUri: Uri.parse(
                "https://i1.sndcdn.com/artworks-000666434224-2kg26y-t500x500.jpg"),
            extras: {
              'stream':
                  'https://dp01.audius.endl.net/v1/tracks/12345/stream?app_name=EXAMPLEAPP',
            })
      ]);
    });

    test('mediaItem2ConcatenatedAudioSource test', () {
      List<MediaItem> _mediaItems = [
        MediaItem(id: '12345', album: 'Lorem Ipsum', title: 'Lorem Ipsum')
      ];

      expect(
        Parsing.mediaItem2AudioSource(_mediaItems)
            .children
            .map((s) => (s as UriAudioSource).uri)
            .toList(),
        ConcatenatingAudioSource(children: [
          AudioSource.uri(
              Uri.parse('https://creatornode.audius.co/tracks/stream/12345'))
        ]).children.map((s) => (s as UriAudioSource).uri).toList(),
      );
    });

    // test('direct map2ConcatenatingAudioSource test', () {
    //   expect(
    //     ConcatenatingAudioSource(
    //             children: List.of(Parsing.map2MediaItem(maps)
    //                 .map((mediaItem) =>
    //                     AudioSource.uri(mediaItem.extras!['stream']))
    //                 .toList()))
    //         .children
    //         .map((e) => (e as UriAudioSource).uri)
    //         .toList(),
    //     ConcatenatingAudioSource(children: [
    //       AudioSource.uri(Uri.parse(
    //           'https://dp01.audius.endl.net/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP'))
    //     ]).children.map((e) => (e as UriAudioSource).uri).toList(),
    //   );
    // });

    // test('track2ConcatenatingAudioSource test', () => expect(
    //   Parsing.track2AudioSource(tracks).children.map((s) => (s as UriAudioSource).uri).toList(),
    //   [Uri.parse('https://dp01.audius.endl.net/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP')]
    // ));
  });
}
