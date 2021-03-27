import 'dart:convert' as convert;
import 'package:audius_flutter_client/audio/audio_player_task.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import 'package:audius_flutter_client/audio/convert2queue.dart';
import 'package:audius_flutter_client/models/track.dart';
import '../constants.dart';


class TrackCard extends StatelessWidget {
  TrackCard(this.targetTrack, this.queue, this.selectedTrackIndex);

  final Track targetTrack;
  final ConcatenatingAudioSource queue;
  final int selectedTrackIndex;

  @override
  Widget build(BuildContext context) {
    print('queue type: ${queue.runtimeType}');

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
        onTap: () {
          if (AudioService.currentMediaItem == null) {
            AudioService.start(
                backgroundTaskEntrypoint: backgroundTaskEntrypoint,
                params: {
                  'queue': queue,
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
    ConcatenatingAudioSource queue = queueConverter(trackList);
    print("${queue.runtimeType}");
    return jsonResponse
        .map(
          (track) => TrackCard(
            Track.fromJson(track),
            queue,
            jsonResponse.indexOf(track),
          ),
        )
        .toList();
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
