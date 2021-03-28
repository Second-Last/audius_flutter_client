import 'dart:convert' as convert;
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/audio/convert2media.dart';
import 'package:audius_flutter_client/models/track.dart';
import '../constants.dart';

late List<Map<String, dynamic>> _queue;

class TrackCard extends StatelessWidget {
  TrackCard(this.targetTrack, this.selectedTrackIndex);

  final Track targetTrack;
  final int selectedTrackIndex;

  @override
  Widget build(BuildContext context) {
    print('queue type: ${_queue.runtimeType}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
        child: Card(
          child: Column(
            children: [
              Image.network(targetTrack.artwork!['150x150']!),
              // TODO: use StreamBuilder
              Text('Track $selectedTrackIndex'),
              Text('UID: ${targetTrack.user.id}')
            ],
          ),
        ),
        onTap: () async {
          if (AudioService.currentMediaItem == null) {
            print('Starting AudioService...');
            await AudioService.start(
                backgroundTaskEntrypoint: backgroundTaskEntrypoint,
                params: {
                  'queue': _queue,
                  'initialTrackIndex': selectedTrackIndex,
                });
          } else {}
        },
      ),
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
    _queue = Parsing.track2Map(trackList);
    print("${_queue.runtimeType}");
    return jsonResponse
        .map(
          (track) => TrackCard(
            Track.fromJson(track),
            jsonResponse.indexOf(track),
          ),
        )
        .toList();
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
