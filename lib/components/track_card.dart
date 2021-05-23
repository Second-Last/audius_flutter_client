import 'dart:convert' as convert;
import 'dart:developer' as dev;

import 'package:audius_flutter_client/services/network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/audio/convert2media.dart';
import 'package:audius_flutter_client/models/track.dart';
import '../audio/audio_player_task.dart';
import '../constants.dart';

class TrackCard extends StatelessWidget {
  TrackCard(this._targetTrack, this._selectedTrackIndex, this._queue);

  final Track _targetTrack;
  final int _selectedTrackIndex;
  final List<Track> _queue;
  late final List<MediaItem> _playList = Parsing.track2MediaItem(_queue);
  // TODO: optimize above, might be able to run in background

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: StreamBuilder<QueueState>(
          stream: queueStateStream,
          initialData: null,
          builder: (context, snapshot) {
            return GestureDetector(
              child: Card(
                child: Column(
                  children: [
                    _targetTrack.artwork != null
                        ? Image.network(_targetTrack.artwork!.x150!)
                        : Icon(Icons.art_track, size: 150),
                    // TODO: use StreamBuilder
                    Text('Track $_selectedTrackIndex'),
                    Text('UID: ${_targetTrack.user.id}')
                  ],
                ),
              ),
              onTap: () async {
                // TODO: detect if it's the same playlist, then choose to reset,
                if (snapshot.data == null || !AudioService.running) {
                  // Audio hasn't been played before
                  print('Starting AudioService...');
                  await AudioService.start(
                    backgroundTaskEntrypoint: backgroundTaskEntrypoint,
                    androidNotificationChannelName: 'Audio Service Demo',
                    androidNotificationColor: 0xFF6A1B9A,
                    androidNotificationIcon: 'mipmap/ic_launcher',
                    androidEnableQueue: true,
                  );
                  print('Trying to update queue');
                  await AudioService.updateQueue(_playList);
                  await AudioService.skipToQueueItem(_targetTrack.id);
                  AudioService.play();
                } else {
                  bool _sameTrack = snapshot.data?.mediaItem?.id ==
                      _playList[_selectedTrackIndex].id;
                  bool _samePlayList = true;
                  for (var i = 0; i < snapshot.data!.queue!.length; i++) {
                    if (_playList[i].id != snapshot.data?.queue?[i].id) {
                      _samePlayList = false;
                      break;
                    }
                  }

                  if (!_sameTrack && !_samePlayList) {
                    await AudioService.pause();
                    await AudioService.updateQueue(_playList);
                    await AudioService.skipToQueueItem(_targetTrack.id);
                    AudioService.play();
                  } else if (!_sameTrack) {
                    AudioService.skipToQueueItem(_targetTrack.id);
                  } else if (!_samePlayList) {
                    await AudioService.pause();
                    await AudioService.updateQueue(_playList);
                    await AudioService.skipToQueueItem(_targetTrack.id);
                    AudioService.play();
                  }

                  // print(
                  //     'Built-in detect: ${_playList == snapshot.data?.queue}');
                  // // Already playing/started
                  // if (_playList != snapshot.data?.queue) {
                  //   await AudioService.pause();
                  //   await AudioService.updateQueue(_playList);
                  //   await AudioService.skipToQueueItem(_targetTrack.id);
                  //   AudioService.play();
                  // }
                  // dev.log(
                  //   'Previous song',
                  //   name: 'MediaItem compare',
                  //   error: snapshot.data!.mediaItem,
                  // );
                  // dev.log(
                  //   'Current song',
                  //   name: 'MediaItem compare',
                  //   error: _playList[_selectedTrackIndex],
                  // );
                  // if (snapshot.data?.mediaItem?.id !=
                  //     _playList[_selectedTrackIndex].id) {
                  //   print('We are on a different song!');
                  //   await AudioService.skipToQueueItem(_targetTrack.id);
                  // }
                }
              },
            );
          }),
    );
  }
}
