import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:audius_flutter_client/models/track.dart';
import '../constants.dart';

class TrackCard extends StatelessWidget {
  TrackCard(this.targetTrack);

  final Track targetTrack;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
        child: Card(
          child: Column(
            children: [
              Image.network(targetTrack.artwork!['150x150']!),
              // TODO: use StreamBuilder
              Text('Track'),
              Text('UID: ${targetTrack.user.id}')
            ],
          ),
        ),
        onTap: () => {},
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
    var jsonResponse = convert.jsonDecode(response.body)['data'];
    List<Track> trackList = List.from(jsonResponse.map((track) => Track.fromJson(track)).toList());

    return List.from(
        jsonResponse.map((track) => TrackCard(Track.fromJson(track))).toList());
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
