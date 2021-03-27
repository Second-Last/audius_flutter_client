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
      child: Card(
        child: Column(
          children: [
            Image.network(targetTrack.artwork!['480x480']!),
            // TODO: use StreamBuilder
            Text('Track'),
            Text('${targetTrack.playCount} Plays')
          ],
        ),
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
    return List.from(
        jsonResponse.map((track) => TrackCard(Track.fromJson(track))).toList());
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
