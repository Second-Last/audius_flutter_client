import 'package:audius_flutter_client/models/user.dart';
import 'package:audius_flutter_client/services/network.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:audius_flutter_client/models/track.dart';

void main() async {
  group('network client test:', () {
    test('initialization test', () async {
      expect(Network.setHost(), completes);
    });

    test('search track test', () async {
      expect(Network.searchTrack('Freely Tomorrow'), completes);
    });

    test('get track test', () async {
      // final Track targetTrack = Track(
      //     artwork: {
      //       '150x150':
      //           "https://creatornode.audius.co/ipfs/QmVJjA6zXhDZn3BjcjYa33P9NDiPZj7Vyq9TCx1bHjvHmG/150x150.jpg",
      //       '480x480':
      //           "https://creatornode.audius.co/ipfs/QmVJjA6zXhDZn3BjcjYa33P9NDiPZj7Vyq9TCx1bHjvHmG/480x480.jpg",
      //       '1000x1000':
      //           "https://creatornode.audius.co/ipfs/QmVJjA6zXhDZn3BjcjYa33P9NDiPZj7Vyq9TCx1bHjvHmG/1000x1000.jpg"
      //     },
      //     id: 'iD7KyDd',
      //     repostCount: 277,
      //     favoriteCount: 644,
      //     title:
      //         "Paauer | Baauer B2B Party Favor | B&L Block Party LA (Live Set)",
      //     rawUser: {
      //       'album_count': 0,
      //       'bio':
      //           "Makin' moves & keeping you on your toes.\nlinktr.ee/browniesandlemonade",
      //       'cover_photo': {
      //         '640x':
      //             "https://creatornode.audius.co/ipfs/QmcVZH5C2ygxoVS4ihPBJrkFrS1Ua6YJB5srNtXafPzihZ/640x.jpg",
      //         '2000x': "https://creatornode.audius.co/ipfs/QmcVZH5C2ygxoVS4ihPBJrkFrS1Ua6YJB5srNtXafPzihZ/2000x.jpg"
      //       }
      //     },
      //     genre: "Electronic",
      //     mood: "Fiery",
      //     releaseDate: "Mon Sep 23 2019 12:35:10 GMT-0700",
      //     remixOf: {'tracks': null},
      //     duration: Duration(seconds: 5265),
      //     playCount: 318403);

      expect((await Network.getTrack('D7KyD')).id, 'D7KyD');
    });

    test('search user test', () async {
      expect(Network.searchUser('Mitchie M'), completes);
    });

    test('get user test', () async {
      User targetUser = (await Network.getUser('nlGNe'));

      expect(targetUser.id, 'nlGNe');
      expect(targetUser.name, "Brownies & Lemonade");
    });

    test('search playlist test', () async {
      expect(Network.searchPlaylist('Hot & New'), completes);
    });

    test('get playlist test', () async {
      expect((await Network.getPlaylist('DOPRl')).playlistName, "Hot & New on Audius 🔥");
    });

    test('get playlist tracks test', () async {
      expect(Network.getPlaylistTracks('DOPRl'), completes);
    });
  });
}
