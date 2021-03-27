import 'package:just_audio/just_audio.dart';

import 'package:audius_flutter_client/models/track.dart';

ConcatenatingAudioSource queueConverter(List<Track> tracks) {
  return ConcatenatingAudioSource(
    children: List.from(tracks
        .map((track) => AudioSource.uri(
              Uri.parse(
                  'https://discoveryprovider.audius3.prod-us-west-2.staked.cloud/v1/tracks/${track.id}/stream?app_name=EXAMPLEAPP'),
              tag: AudioMetadata(
                album: track.title, // TODO: the api doesn't give album names
                title: track.title,
                artwork: track.artwork!['1000x1000'],
                artist: track.user.name,
              )
            ))
        .toList()),
  );
}


class AudioMetadata {
  final String album;
  final String title;
  final String artwork;
  final String artist;

  AudioMetadata(
      {required this.album, required this.title, required this.artwork, required this.artist});
}