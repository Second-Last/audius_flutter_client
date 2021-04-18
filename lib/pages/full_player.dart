import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FullPlayer extends StatefulWidget {
  @override
  _FullPlayerState createState() => _FullPlayerState();
}

class _FullPlayerState extends State<FullPlayer> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 250),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AUDIUS'),
      ),
      body: Center(
        child: StreamBuilder<bool>(
          stream: AudioService.runningStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return SizedBox();
            }
            final running = snapshot.data ?? false;
            if (!running) {
              return SizedBox(); // When we're not playing
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Queue display/controls.
                StreamBuilder<QueueState>(
                  stream: queueStateStream,
                  builder: (context, snapshot) {
                    final queueState = snapshot.data;
                    final queue = queueState?.queue ?? [];
                    final mediaItem = queueState?.mediaItem;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (mediaItem != null && queue.isNotEmpty)
                          Image.network(
                            mediaItem.artUri.toString(),
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        if (queue.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.skip_previous),
                                iconSize: 64.0,
                                onPressed: mediaItem == queue.first
                                    ? null
                                    : AudioService.skipToPrevious,
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next),
                                iconSize: 64.0,
                                onPressed: mediaItem == queue.last
                                    ? null
                                    : AudioService.skipToNext,
                              ),
                            ],
                          ),
                        if (mediaItem?.title != null) Text(mediaItem!.title),
                      ],
                    );
                  },
                ),
                // Play/pause/stop buttons.
                StreamBuilder<bool>(
                  stream: AudioService.playbackStateStream
                      .map((state) => state.playing)
                      .distinct(),
                  builder: (context, snapshot) {
                    final playing = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (playing) pauseButton() else playButton(),
                        stopButton(),
                      ],
                    );
                  },
                ),
                // A seek bar.
                StreamBuilder<MediaState>(
                  stream: mediaStateStream,
                  builder: (context, snapshot) {
                    final mediaState = snapshot.data;
                    return SeekBar(
                      duration:
                          mediaState?.mediaItem?.duration ?? Duration.zero,
                      position: mediaState?.position ?? Duration.zero,
                      onChangeEnd: (newPosition) {
                        AudioService.seekTo(newPosition);
                      },
                    );
                  },
                ),
                // Display the processing state.
                StreamBuilder<AudioProcessingState>(
                  stream: AudioService.playbackStateStream
                      .map((state) => state.processingState)
                      .distinct(),
                  builder: (context, snapshot) {
                    final processingState =
                        snapshot.data ?? AudioProcessingState.none;
                    return Text(
                        "Processing state: ${describeEnum(processingState)}");
                  },
                ),
                // Display the latest custom event.
                StreamBuilder(
                  stream: AudioService.customEventStream,
                  builder: (context, snapshot) {
                    return Text("custom event: ${snapshot.data}");
                  },
                ),
                // Display the notification click status.
                StreamBuilder<bool>(
                  stream: AudioService.notificationClickEventStream,
                  builder: (context, snapshot) {
                    return Text(
                      'Notification Click Status: ${snapshot.data}',
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         leading: IconButton(
  //           icon: Icon(
  //             Icons.arrow_downward,
  //             color: audiusGrey,
  //           ),
  //           onPressed: () => null,
  //         ),
  //         title: Text(
  //           'NOW PLAYING',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w800,
  //             color: audiusGrey,
  //           ),
  //         ),
  //         centerTitle: true,
  //       ),
  //       body: StreamBuilder(
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState != ConnectionState.active)
  //             return SizedBox();

  //           final running = snapshot.data ?? false;

  //           return StreamBuilder<QueueState>(
  //               stream: queueStateStream,
  //               builder: (context, queueSnapshot) {
  //                 final queueState = snapshot.data;
  //                 final queue = queueState?.queue ?? [];
  //                 final mediaItem = queueState?.mediaItem;

  //                 return Container(
  //                   alignment: Alignment.center,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(25),
  //                         child: Image.network(queueSnapshot
  //                             .data!.mediaItem!.artUri!
  //                             .toString()),
  //                       ),
  //                       // Padding(
  //                       //   padding: const EdgeInsets.symmetric(horizontal: 30),
  //                       //   child: Text(
  //                       //     '${queueSnapshot.data!.mediaItem!.title}',
  //                       //     overflow: TextOverflow.ellipsis,
  //                       //     maxLines: 1,
  //                       //   ),
  //                       // ),
  //                       // Padding(
  //                       //   padding: const EdgeInsets.all(8.0),
  //                       //   child: Text(
  //                       //     '${queueSnapshot.data!.mediaItem!.artist}',
  //                       //     overflow: TextOverflow.ellipsis,
  //                       //     maxLines: 1,
  //                       //   ),
  //                       // ),
  //                       StreamBuilder<PlaybackState>(
  //                           stream: AudioService.playbackStateStream,
  //                           builder: (context, snapshot) {
  //                             final playing = snapshot.data?.playing ?? false;
  //                             if (playing) {
  //                               _animationController.forward();
  //                             } else {
  //                               _animationController.reverse();
  //                             }

  //                             return GestureDetector(
  //                               child: AnimatedIcon(
  //                                 icon: AnimatedIcons.play_pause,
  //                                 progress: _animationController,
  //                                 size: 50,
  //                               ),
  //                               onTap: () {
  //                                 if (playing) {
  //                                   AudioService.pause();
  //                                 } else {
  //                                   AudioService.play();
  //                                 }
  //                               },
  //                             );
  //                           }),
  //                       StreamBuilder<MediaState>(
  //                         stream: mediaStateStream,
  //                         builder: (context, snapshot) {
  //                           var mediaState = snapshot.data;
  //                           return SeekBar(
  //                             duration: mediaState?.mediaItem?.duration ??
  //                                 Duration.zero,
  //                             position: mediaState?.position ?? Duration.zero,
  //                             onChangeEnd: (newPosition) {
  //                               AudioService.seekTo(newPosition);
  //                             },
  //                           );
  //                         },
  //                       ),
  //                       Text('Control Buttons Here!'),
  //                     ],
  //                   ),
  //                 );
  //               });
  //         },
  //       ),
  //     ),
  //     // onVerticalDragDown: (dragDownDetails) => Navigator.pop(context),
  //   );
  // }
}

ElevatedButton startButton(String label, VoidCallback onPressed) =>
    ElevatedButton(
      child: Text(label),
      onPressed: onPressed,
    );

IconButton playButton() => IconButton(
      icon: Icon(Icons.play_arrow),
      iconSize: 64.0,
      onPressed: AudioService.play,
    );

IconButton pauseButton() => IconButton(
      icon: Icon(Icons.pause),
      iconSize: 64.0,
      onPressed: AudioService.pause,
    );

IconButton stopButton() => IconButton(
      icon: Icon(Icons.stop),
      iconSize: 64.0,
      onPressed: AudioService.stop,
    );

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    print('Slider max: ${widget.duration.inMilliseconds.toDouble()}');

    var _value =
        (_dragging ? _dragValue! : widget.position.inMilliseconds.toDouble());
    // var value = min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
    //     widget.duration.inMilliseconds.toDouble());
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return Stack(
      children: [
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: _value,
          onChanged: (value) {
            if (!_dragging) _dragging = true;
            // else
            //   _dragging = false;

            setState(() {
              _dragValue = value;
              print('Current dragValue: $_dragValue');
            });
            if (widget.onChanged != null) {
              widget.onChanged!(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd!(Duration(milliseconds: value.round()));
            }
            _dragging = false;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
