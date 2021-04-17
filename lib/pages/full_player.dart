import 'package:audio_service/audio_service.dart';
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import 'package:audius_flutter_client/components/seekbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FullPlayer extends StatefulWidget {
  @override
  _FullPlayerState createState() => _FullPlayerState();
}

class _FullPlayerState extends State<FullPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 250),
  );

  var myKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_downward,
              color: audiusGrey,
            ),
            onPressed: () => null,
          ),
          title: Text(
            'NOW PLAYING',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: audiusGrey,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QueueState>(
            stream: queueStateStream,
            builder: (context, queueSnapshot) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image.network(
                          queueSnapshot.data!.mediaItem!.artUri!.toString()),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: Text(
                    //     '${queueSnapshot.data!.mediaItem!.title}',
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     '${queueSnapshot.data!.mediaItem!.artist}',
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 1,
                    //   ),
                    // ),
                    StreamBuilder<PlaybackState>(
                        stream: AudioService.playbackStateStream,
                        builder: (context, snapshot) {
                          final playing = snapshot.data?.playing ?? false;
                          if (playing) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }

                          return GestureDetector(
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: _animationController,
                              size: 100,
                            ),
                            onTap: () {
                              if (playing) {
                                AudioService.pause();
                              } else {
                                AudioService.play();
                              }
                            },
                          );
                        }),
                    StreamBuilder<MediaState>(
                    stream: mediaStateStream,
                    builder: (context, snapshot) {
                      var mediaState = snapshot.data;
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
                    Text('Control Buttons Here!'),
                  ],
                ),
              );
            }),
      ),
      // onVerticalDragDown: (dragDownDetails) => Navigator.pop(context),
    );
  }
}