import 'package:audius_flutter_client/models/track.dart';

import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/audio/convert2media.dart';
import 'package:flutter_test/flutter_test.dart';

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
    List<Map<String, dynamic>> maps = track2Map(tracks);
    test('track2Map test', () => expect(maps[0]['id'], '12345'));

    List<MediaItem> mediaItems = map2MediaItem(maps);
    test('map2MediaItem test', () {
      expect(mediaItems[0].artist, 'string');
      expect(
          mediaItems[0].extras!['stream'],
          Uri.parse(
              'https://discoveryprovider.audius3.prod-us-west-2.staked.cloud/v1/tracks/${tracks[0].id}/stream?app_name=EXAMPLEAPP'));
    });
  });
}
