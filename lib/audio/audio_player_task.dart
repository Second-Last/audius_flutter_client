import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audius_flutter_client/audio/convert2media.dart';
import 'package:audius_flutter_client/models/track.dart';

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  var _queue = <MediaItem>[];
  AudioProcessingState? _skipState;
  // Seeker? _seeker;
  late StreamSubscription<PlaybackEvent> _eventSubscription;

  List<MediaItem> get queue => _queue;
  int? get index => _audioPlayer.currentIndex;
  MediaItem? get mediaItem => index == null ? null : queue[index!];

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    // // Reset the queue, just in case
    // _queue.clear();
    // Broadcast that we're connecting, and what controls are available.
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop],
      playing: true,
      processingState: AudioProcessingState.connecting,
    );

    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        AudioServiceBackground.setMediaItem(queue[index]);
      }
    });
    // This breaks the app for some reason...
    // _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
    //   _broadcastState();
    // });
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

  @override
  Future<void> onUpdateQueue(List<MediaItem> _mediaItems) async {
    print('Loading and broadcasting the queue...');
    AudioServiceBackground.setQueue(_queue = _mediaItems);
    print('Successfully set queue!');
    print('Ready to set audio source!');
    await _audioPlayer.setAudioSource(Parsing.mediaItem2AudioSource(_mediaItems));
    print('Successfully set audio source!');
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    if (newIndex == -1) return;
    _skipState = newIndex > index!
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    _audioPlayer.seek(Duration.zero, index: newIndex);
    // await _audioPlayer.seekToNext();
  }

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      androidCompactActions: [0, 1, 3],
      processingState: _getProcessingState(),
      playing: _audioPlayer.playing,
      position: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState!;
    switch (_audioPlayer.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_audioPlayer.processingState}");
    }
  }
}
