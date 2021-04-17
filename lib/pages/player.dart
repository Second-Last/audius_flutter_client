import 'package:audius_flutter_client/components/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';

// Not quite sure which way to import this
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import '../constants.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
  GlobalKey<NavigatorState> get _navigatorKey => GlobalKey<NavigatorState>();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AudioService.currentMediaItemStream,
        builder: (context, snapshot) {
          if (AudioService.currentMediaItem == null) {
            return SizedBox();
          }
          return OpenContainer(
            closedBuilder: (context, action) {
              return SmallPlayer();
            },
            openBuilder: (context, action) {
              return FullPlayer(
                close: action,
                navigatorKey: widget._navigatorKey,
              );
            },
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: Duration(milliseconds: 500),
          );
        });
  }
}

class SmallPlayer extends StatefulWidget {
  const SmallPlayer({
    Key? key,
  }) : super(key: key);

  @override
  _SmallPlayerState createState() => _SmallPlayerState();
}

class _SmallPlayerState extends State<SmallPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 250),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QueueState>(
                stream: queueStateStream,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '${snapshot.data!.mediaItem!.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder<PlaybackState>(
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
                      size: 40,
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
          )
        ],
      ),
    );
  }
}

class FullPlayer extends StatefulWidget {
  const FullPlayer({
    required this.close,
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  final Function close;
  final GlobalKey<NavigatorState> navigatorKey;

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
            onPressed: () => myKey.currentState!.pop(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Image.network(
                          queueSnapshot.data!.mediaItem!.artUri!.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        '${queueSnapshot.data!.mediaItem!.title}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${queueSnapshot.data!.mediaItem!.artist}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
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
