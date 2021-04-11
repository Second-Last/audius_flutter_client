import 'dart:convert' as convert;
import 'package:audius_flutter_client/audio/convert2media.dart';

import '../audio/audio_player_task.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/models/track.dart';
import '../constants.dart';

class TrackCard extends StatelessWidget {
  TrackCard(this._targetTrack, this._selectedTrackIndex, this._queue);

  final Track _targetTrack;
  final int _selectedTrackIndex;
  final List<Track> _queue;
  late final List<MediaItem> _playList = Parsing.track2MediaItem(_queue);

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
                    Image.network(_targetTrack.artwork!['150x150']!),
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
                  await AudioService.updateQueue(_playList);
                  await AudioService.skipToQueueItem(_targetTrack.id);
                  AudioService.play();
                } else {
                  // Check if we are repeating playlist
                  // Simply comparing don't work cuz of audio_service's conversion
                  bool repeatingPlayList = true;
                  for (var i = 0; i < snapshot.data!.queue!.length; i++) {
                    if (_playList[i].id != snapshot.data!.queue![i].id) {
                      repeatingPlayList = false;
                      break;
                    }
                  }
                  // Already playing/started
                  if (!repeatingPlayList) {
                    await AudioService.pause();
                    await AudioService.updateQueue(_playList);
                  }
                  if (snapshot.data!.mediaItem !=
                      _playList[_selectedTrackIndex]) {
                    await AudioService.skipToQueueItem(_targetTrack.id);
                    AudioService.play();
                  }
                }
              },
            );
          }),
    );
  }
}

Future<List<TrackCard>> trackCardBuilder(String query,
    {bool onlyDownloadable = false}) async {
  var url = Uri.https('audius-metadata-2.figment.io', 'v1/tracks/search',
      {'query': '$query', 'app_name': 'Audius Flutter Client'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = convert.jsonDecode(response.body)['data'];
    List<Track> trackList =
        List.from(jsonResponse.map((track) => Track.fromJson(track)).toList());
    return jsonResponse
        .map(
          (track) => TrackCard(
            Track.fromJson(track),
            jsonResponse.indexOf(track),
            trackList,
          ),
        )
        .toList();
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
