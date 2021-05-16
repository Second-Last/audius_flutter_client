import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

import '../../constants.dart';

class ShuffleModeButton extends StatefulWidget {
  @override
  _ShuffleModeButtonState createState() => _ShuffleModeButtonState();
}

class _ShuffleModeButtonState extends State<ShuffleModeButton>
    with TickerProviderStateMixin {
  int _rotationAngle = 0;
  static const Duration _animationDuration = Duration(milliseconds: 250);
  late Animation<Color?> _colorAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _colorAnimation = ColorTween(begin: Colors.black, end: audiusColor)
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0, 1),
    ));
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream.distinct(),
      builder: (context, playBackStateStream) {
        final _shuffleMode = playBackStateStream.data?.shuffleMode ?? false;

        // ignore: unnecessary_null_comparison
        if (_shuffleMode == false) return SizedBox();

        return Stack(
          children: [
            RotationTransition(
              turns: _animationController,
              child: GestureDetector(
                  child: Icon(
                    Icons.shuffle,
                    color: _colorAnimation.value,
                  ),
                  onTap: () async {
                    switch (_rotationAngle % 360) {
                      case 0:
                        _animationController.forward();
                        assert(_shuffleMode == AudioServiceShuffleMode.none);
                        setState(() {
                          _rotationAngle += 180;
                        });
                        dev.log('Setting shuffle to \"all\"');
                        // await AudioService.setShuffleMode(
                        // AudioServiceShuffleMode.all);
                        break;
                      case 180:
                        _animationController.repeat();
                        setState(() => _rotationAngle += 180);
                        dev.log('Setting shuffle to \"none\"');
                        break;
                      default:
                        dev.log(
                          'Unexpected shuffle button angle',
                          error:
                              'Unexpected _rotationAngle value for ShuffleModeButton: $_rotationAngle',
                        );
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
