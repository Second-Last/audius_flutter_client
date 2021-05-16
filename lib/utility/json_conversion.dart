import 'dart:convert' as convert;

import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/models/user.dart';

List<Track> parseTracks(String responseBody) {
  final parsed = convert.jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();

  return parsed.map<Track>((json) => Track.fromJson(json)).toList();
}

List<User> parseUsers(String responseBody) {
  final parsed = convert.jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
