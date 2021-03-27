import 'package:just_audio/just_audio.dart';

import 'package:audius_flutter_client/models/track.dart';

ConcatenatingAudioSource queueConverter(List<Track> tracks) {
  try {
    return ConcatenatingAudioSource(
    children: tracks
        .map((track) => AudioSource.uri(
              Uri.parse(
                  'https://discoveryprovider.audius3.prod-us-west-2.staked.cloud/v1/tracks/${track.id}/stream?app_name=EXAMPLEAPP'),
              tag: track,
            ))
        .toList(),
  );
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