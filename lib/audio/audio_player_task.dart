import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';

import 'package:audius_flutter_client/audio/convert2media.dart';

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  AudioPlayer _audioPlayer = new AudioPlayer();
  AudioProcessingState? _skipState;
  var _queue = <MediaItem>[];
//   Seeker? _seeker;
  late StreamSubscription<PlaybackEvent> _eventSubscription;

  List<MediaItem> get queue => _queue;

  int? get index => _audioPlayer.currentIndex;
  MediaItem? get mediaItem => index == null ? null : queue[index!];

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    // Broadcast media item changes.
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) AudioServiceBackground.setMediaItem(queue[index]);
    });

    // Propagate all events from the audio player to AudioService clients.
    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });

    // Special processing for state transitions.
    _audioPlayer.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          // TODO: In this example, the service stops when reaching the end.
          onStop();
          break;
        case ProcessingState.ready:
          // If we just came from skipping between tracks, clear the skip
          // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    // Then default implementations of onSkipToNext and onSkipToPrevious will
    // delegate to this method.
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    if (newIndex == -1) return;
    // During a skip, the player may enter the buffering state. We could just
    // propagate that state directly to AudioService clients but AudioService
    // has some more specific states we could use for skipping to next and
    // previous. This variable holds the preferred state to send instead of
    // buffering during a skip, and it is cleared as soon as the player exits
    // buffering (see the listener in onStart).
    _skipState = newIndex > index!
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    // This jumps to the beginning of the queue item at newIndex.
    _audioPlayer.seek(Duration.zero, index: newIndex);
    // Demonstrate custom events.
    AudioServiceBackground.sendCustomEvent('skip to $newIndex');
  }

  @override
  Future<void> onUpdateQueue(List<MediaItem> _mediaItems) async {
    AudioServiceBackground.setQueue(_queue = _mediaItems);
    print('bg set queue successful!');
    await _audioPlayer
        .setAudioSource(Parsing.mediaItem2AudioSource(_mediaItems));
    print('Successfully updated audio source!');
  }

  @override
  Future<void> onPlay() => _audioPlayer.play();

  @override
  Future<void> onPause() => _audioPlayer.pause();

  @override
  Future<void> onSeekTo(Duration position) => _audioPlayer.seek(position);

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);

  // Do I need await here? Seems unnecessary
  @override
  Future<void> onSetShuffleMode(shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.all:
        await _audioPlayer.setShuffleModeEnabled(true);
        await _audioPlayer.shuffle();
        break;
      default:
        await _audioPlayer.setShuffleModeEnabled(false);
        break;
    }
  }

  // Same as above
  @override
  Future<void> onSetRepeatMode(repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.all:
        await _audioPlayer.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.one:
        await _audioPlayer.setLoopMode(LoopMode.one);
        break;
      default:
        await _audioPlayer.setLoopMode(LoopMode.off);
    }
  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  /// Jumps away from the current position by [offset].
  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _audioPlayer.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > mediaItem!.duration!) newPosition = mediaItem!.duration!;
    // Perform the jump via a seek.
    await _audioPlayer.seek(newPosition);
  }

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop, // Don't remove this! App will not work for some reason
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

// A stream reporting the combined state of the current queue and the current
// media item within that queue.
class QueueState {
  final List<MediaItem>? queue;
  final MediaItem? mediaItem;

  QueueState(this.queue, this.mediaItem);
}

Stream<QueueState> get queueStateStream =>
    Rx.combineLatest2<List<MediaItem>?, MediaItem?, QueueState>(
        AudioService.queueStream,
        AudioService.currentMediaItemStream,
        (queue, mediaItem) => QueueState(queue, mediaItem));

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

Stream<MediaState> get mediaStateStream =>
    Rx.combineLatest2<MediaItem?, Duration, MediaState>(
        AudioService.currentMediaItemStream,
        AudioService.positionStream,
        (mediaItem, position) => MediaState(mediaItem, position));

class Seeker {
  final AudioPlayer player;
  final Duration positionInterval;
  final Duration stepInterval;
  final MediaItem mediaItem;
  bool _running = false;

  Seeker(
    this.player,
    this.positionInterval,
    this.stepInterval,
    this.mediaItem,
  );

  start() async {
    _running = true;
    while (_running) {
      Duration newPosition = player.position + positionInterval;
      if (newPosition < Duration.zero) newPosition = Duration.zero;
      if (newPosition > mediaItem.duration!) newPosition = mediaItem.duration!;
      player.seek(newPosition);
      await Future.delayed(stepInterval);
    }
  }

  stop() {
    _running = false;
  }
}
