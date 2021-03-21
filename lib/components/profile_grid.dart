import 'package:flutter/material.dart';
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
                      )
                    : Container(), // I can't use null here, I guess
                // TODO: Audius Badge for displaying $AUDIO amount
              ],
            ),
          ],
        ),
        onTap: () => print('User tapped on ${targetUser.name}'),
      ),
      elevation: 10,
    );
  }
}
