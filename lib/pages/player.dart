import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:audio_service/audio_service.dart';

// Not quite sure which way to import this
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import '../constants.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AudioService.runningStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return SizedBox();
          }
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
                    return FullPlayer();
                  },
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: Duration(milliseconds: 200),
                );
              });
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
    duration: Duration(seconds: 1),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('My Song'),
          ),
          Spacer(),
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
              }
            ),
          )
        ],
      ),
    );
  }
}

class FullPlayer extends StatefulWidget {
  const FullPlayer({
    Key? key,
  }) : super(key: key);

  @override
  _FullPlayerState createState() => _FullPlayerState();
}

class _FullPlayerState extends State<FullPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: AudioService.playbackStateStream,
                  builder: (context, snapshot) {
                    // final playing = snapshot.data?.playing ?? false;

                    return IconButton(
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _animationController,
                        ),
                        onPressed: () {});
                  }),
              Text('Player!')
            ],
          ),
        ),
      ),
      onVerticalDragDown: (dragDownDetails) => Navigator.pop(context),
    );
  }
}

play() async {
  if (await AudioService.running) {
    AudioService.play();
  } else {
    AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint);
  }
}

pause() => AudioService.pause();

stop() => AudioService.stop();

_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
