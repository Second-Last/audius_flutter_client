import 'dart:convert' as convert;

import 'package:audius_flutter_client/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            ClipOval(
              child: targetUser.profilePicture != null
                  ? Image.network(targetUser.profilePicture!['150x150'])
                  : Icon(Icons.account_circle, size: 150),
            ),
            Text(
              '${targetUser.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  "${targetUser.followerCount} followers",
                  maxLines: 1,
                  overflow: TextOverflow
                      .ellipsis, // TODO: 1K, 2K, and stuffs like that
                ),
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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(user: targetUser),
          ),
        ),
      ),
      elevation: 10,
    );
  }
}
