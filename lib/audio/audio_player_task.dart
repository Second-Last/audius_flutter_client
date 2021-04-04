import 'package:audio_service/audio_service.dart';
import 'package:audius_flutter_client/audio/convert2media.dart';
import 'package:just_audio/just_audio.dart';

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {

    // Broadcast that we're connecting, and what controls are available.
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop],
      playing: true,
      processingState: AudioProcessingState.connecting,
    );
    // TODO: Connect to the URL
    print('Ready to set audio source!');

    // AudioServiceBackground.setQueue(map2MediaItem(params!['queue']));
    print('Loading and broadcasting the queue...');
    for (var mediaItem in Parsing.map2MediaItem(params!['queue'])) {
      print('${AudioSource.uri(Uri.parse(mediaItem.extras!['stream']))}');
    }
    try {
      // await _audioPlayer.setUrl('https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3');
      // await _audioPlayer.setAudioSource(
      //   AudioSource.uri(Uri.parse('https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3')),
      //   preload: false,
      // );
      Future.delayed(Duration(seconds: 1));
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: Parsing.map2MediaItem(params['queue']).map((mediaItem) => AudioSource.uri(Uri.parse(mediaItem.extras!['stream']))).toList(),),
        initialIndex: params['initialTrackIndex'],
      );
    } catch (e) {
      throw Exception(e);
    }
    print('Ready to play!');
    onPlay();
    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop],
      playing: true,
      processingState: AudioProcessingState.ready,
    );
  }

  @override
  Future<void> onStop() async {
    // Stop playing audio.
    _audioPlayer.stop();
    // Broadcast that we've stopped.
    await AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    // Shut down this background task
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);
    // Start playing audio.
    await _audioPlayer.play();
  }

  @override
  Future<void> onPause() async {
    // Broadcast that we're paused, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.play, MediaControl.stop],
        playing: false,
        processingState: AudioProcessingState.ready);
    // Pause the audio.
    await _audioPlayer.pause();
  }
}
