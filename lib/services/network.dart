import 'dart:convert' as convert;
import 'dart:math' as math;
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import 'package:audius_flutter_client/constants.dart';
import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/models/user.dart';
import 'package:audius_flutter_client/models/playlist.dart';
import 'package:audius_flutter_client/utility/json_conversion.dart';

class Network {
  static var client = RetryClient(http.Client()); // TODO: customize retry conditions
  static late int currentHostIndex;
  static late String host;

  /// Randomly set the host to connect to
  static Future<void> setHost() async {
    List<dynamic> hostList = await getHostList();
    currentHostIndex = math.Random().nextInt(hostList.length - 1);
    host = hostList[currentHostIndex]
        .toString()
        .substring(8); // Removes the https://
    print('Selected host: ${hostList[currentHostIndex]}');
  }

  /// Get a list of available host
  static Future<List<dynamic>> getHostList() async {
    late var jsonResponse;
    try {
      jsonResponse = await http.get(Uri.parse('https://api.audius.co'));
    } catch (e) {
      throw Exception(e);
    }
    List<dynamic> hostList = convert.jsonDecode(jsonResponse.body)['data'];
    return hostList;
  }

  /// Search for a track
  static Future<List<Track>> searchTrack(String query,
      {bool onlyDownloadable = false}) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = await client.get(Uri.https(
          host, '/v1/tracks/search', {'query': query, 'app_name': appName}));
    } catch (e) {
      // TODO: automatically switch to another host when failed 2~3 times
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: consider if this needs to be put into a trycatch
    return compute(parseTracks, jsonResponse.body);
  }

  /// Fetch a single track
  static Future<Track> getTrack(String id) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = (await client.get(
          Uri.https(host, 'v1/tracks/$id', {'app_name': appName})));
      dev.log('jsonResponse', error: jsonResponse);
    } catch (e) {
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: perhaps we need benchmarking to determine whether it's necessary to put this in background
    return Track.fromJson(convert.jsonDecode(jsonResponse.body)['data']);
  }

  /// Search for a user
  static Future<List<User>> searchUser(String query,
      {bool onlyDownloadable = false}) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = await client.get(Uri.https(
          host, '/v1/users/search', {'query': query, 'app_name': appName}));
    } catch (e) {
      // TODO: automatically switch to another host when failed 2~3 times
      dev.log('Network request failed', error: e);
      throw Error();
    }

    return compute(parseUsers, jsonResponse.body);
  }

  /// Fetch a single user
  static Future<User> getUser(String id) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = (await client.get(
          Uri.https(host, 'v1/users/$id', {'app_name': appName})));
    } catch (e) {
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: perhaps we need benchmarking to determine whether it's necessary to put this in background
    return User.fromJson(convert.jsonDecode(jsonResponse.body)['data']);
  }

  /// Search for a playlist
  static Future<List<Playlist>> searchPlaylist(String query) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = await client.get(Uri.https(
          host, '/v1/playlists/search', {'query': query, 'app_name': appName}));
    } catch (e) {
      // TODO: automatically switch to another host when failed 2~3 times
      dev.log('Network request failed', error: e);
      throw Error();
    }

    return compute(parsePlaylists, jsonResponse.body);
  }

  /// Fetch a single playlist's information/data, not including tracks
  static Future<Playlist> getPlaylist(String id) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = (await client.get(
              Uri.https(host, 'v1/playlists/$id', {'app_name': appName})));
    } catch (e) {
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: perhaps we need benchmarking to determine whether it's necessary to put this in background
    return Playlist.fromJson(convert.jsonDecode(jsonResponse.body)['data'][0]);
  }

  static Future<List<Track>> getPlaylistTracks(String id) async {
    late http.Response jsonResponse;

    try {
      jsonResponse = await client.get(
          Uri.https(host, '/v1/playlists/$id/tracks', {'app_name': appName}));
    } catch (e) {
      // TODO: automatically switch to another host when failed 2~3 times
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: consider if this needs to be put into a trycatch
    return compute(parseTracks, jsonResponse.body);
  }
}
