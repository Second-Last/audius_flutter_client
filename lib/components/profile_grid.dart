import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:audius_flutter_client/models/user.dart';
import '../constants.dart';

class ProfileGrid extends StatelessWidget {
  ProfileGrid(this.targetUser);

  final User targetUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        child: Column(
          children: [
            targetUser.profilePicture != null
                ? Image.network(targetUser.profilePicture!['150x150'])
                : Icon(Icons.account_circle, size: 150),
            Text('${targetUser.name}'),
            Row(
              children: [
                Text("${targetUser.followerCount} followers"),
                targetUser.isVerified
                    ? Icon(
                        Icons.check_circle,
                        color: audiusColor,
                        size: 12,
                      )
                    : Container(), // I can't use null here, I guess
                // TODO: Audius Badge for displaying $AUDIO amount
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
        onTap: () => print('User tapped on ${targetUser.name}'),
      ),
      elevation: 10,
    );
  }
}

// TODO: requests the data everytime page changes!
Future<List<ProfileGrid>> gridBuilder(String query) async {
  var url = Uri.https('audius-metadata-2.figment.io', 'v1/users/search',
      {'query': '$query', 'app name': 'Audius Flutter Client'});
  print('Current target url: ${url.toString()}');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print('Request finished with status ${response.statusCode}');
    var jsonResponse = convert.jsonDecode(response.body)['data'];
    return List.from(
        jsonResponse.map((e) => ProfileGrid(User.fromJson(e))).toList());
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
