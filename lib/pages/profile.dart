import 'package:audius_flutter_client/models/user.dart';
import 'package:flutter/material.dart';

import 'package:audius_flutter_client/constants.dart';
import 'package:audius_flutter_client/services/network.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.user});

  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.user.coverPhoto!['640x']);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: audiusGrey,
          ),
          onPressed: () => null,
          // onPressed: () => Navigator.pop(context),
        ),
        title: Text('AUDIUS', style: TextStyle(color: audiusGrey, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Icons.more_vert,
              color: audiusGrey,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(widget.user.coverPhoto!['640x'])
        ]
      ),
    );
  }
}
