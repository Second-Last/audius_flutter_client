import 'package:flutter/material.dart';

import 'package:audius_flutter_client/constants.dart';
import 'package:audius_flutter_client/models/user.dart';
import 'package:audius_flutter_client/utility/number_conversion.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: audiusGrey,
          ),
          // onPressed: () => null,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('AUDIUS',
            style: TextStyle(color: audiusGrey, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Icons.more_horiz,
              color: audiusGrey,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  if (widget.user.coverPhoto != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image.network(widget.user.coverPhoto!.x640!),
                        Positioned(
                          top: 20,
                          right: 15,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            child: Text(
                              'A R T I S T',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.user.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: audiusGrey,
                                  ),
                                ),
                                if (widget.user.isVerified)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: audiusColor,
                                      size: 16,
                                    ),
                                  )
                              ],
                            ),
                            Text(
                              "@${widget.user.handle}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: audiusLightGrey,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.notifications,
                                size: 20,
                                color: audiusGrey,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: audiusLightGrey!),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "FOLLOWED",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: audiusColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                left: 20,
                top: 60,
                child: ClipOval(
                  child: widget.user.profilePicture != null
                      ? Image.network(
                          widget.user.profilePicture!.p150x150!,
                          scale: 1.5,
                        )
                      : Icon(
                          Icons.account_circle,
                          color: audiusGrey,
                          size: 150,
                        ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              spacing: 15,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: convertNumber(widget.user.trackCount),
                        style: TextStyle(
                          color: audiusGrey,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' Tracks',
                        style: TextStyle(color: audiusLightGrey),
                      )
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: convertNumber(widget.user.followerCount),
                        style: TextStyle(
                          color: audiusGrey,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' Followers',
                        style: TextStyle(color: audiusLightGrey),
                      )
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: convertNumber(widget.user.followeeCount),
                        style: TextStyle(
                          color: audiusGrey,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' Following',
                        style: TextStyle(color: audiusLightGrey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
