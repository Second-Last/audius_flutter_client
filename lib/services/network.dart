import 'dart:convert' as convert;
import 'dart:math' as math;
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:audius_flutter_client/constants.dart';
import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/models/user.dart';
import 'package:audius_flutter_client/utility/json_conversion.dart';

class Network {
  static var client = http.Client();
  static late int currentHostIndex;
  static late String host;

  static Future<void> setHost() async {
    List<dynamic> hostList = await getHostList();
    currentHostIndex = math.Random().nextInt(hostList.length - 1);
    host = hostList[currentHostIndex]
        .toString()
        .substring(8); // Removes the https://
    print('Selected host: ${hostList[currentHostIndex]}');
  }

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

  static Future<Track> getTrack(String id) async {
    late var jsonResponse;

    try {
      jsonResponse = (await client.get(
              Uri.https(host, 'v1/tracks', {'query': id, 'app_name': appName})))
          .body;
    } catch (e) {
      dev.log('Network request failed', error: e);
      throw Error();
    }

    // TODO: perhaps we need benchmarking to determine whether it's necessary to put this in background
    return Track.fromJson(jsonResponse.body['data']);
  }

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

  static Future<User> getUser(String id) async {
    late var jsonResponse;

    try {
      jsonResponse = (await client.get(
              Uri.https(host, 'v1/users', {'query': id, 'app_name': appName})))
          .body;
    } catch (e) {
      dev.log('Network request failed', error: e);
      throw Error();
    }

    return User.fromJson(jsonResponse.body['data']);
  }
}
