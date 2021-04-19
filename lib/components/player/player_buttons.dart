import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:animated_rotation/animated_rotation.dart';

class ShuffleModeButton extends StatefulWidget {
  @override
  _ShuffleModeButtonState createState() => _ShuffleModeButtonState();
}

class _ShuffleModeButtonState extends State<ShuffleModeButton> {
  int rotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream.distinct(),
      builder: (context, playBackStateStream) {
        final _playBack =
            playBackStateStream.data?.shuffleMode ?? false;

        // ignore: unnecessary_null_comparison
        if (_playBack == false) return SizedBox();

        return Stack(
          children: [
            AnimatedRotation(
              angle: rotationAngle,
              duration: Duration(milliseconds: 250),
              child: GestureDetector(
                  child: Icon(Icons.repeat_rounded),
                  onTap: () {
                    switch (rotationAngle) {
                      case 0:
                        // assert(shuffleMode == AudioServiceShuffleMode.none);
                        setState(() => rotationAngle += 180);
                        // await AudioService.setShuffleMode(AudioServiceShuffleMode.all);
                        break;
                      case 180:
                        setState(() => rotationAngle += 90);
                        break;
                      case 270:
                        setState(() => rotationAngle += 90);
                        break;
                      default:
                        break;
                    }
                  }),
            )
          ],
        );
      },
    );
  }
}
