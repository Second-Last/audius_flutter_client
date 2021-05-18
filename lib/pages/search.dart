import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:audius_flutter_client/services/network.dart';
import 'package:audius_flutter_client/models/playlist.dart';
import 'package:audius_flutter_client/models/track.dart';
import 'package:audius_flutter_client/models/user.dart';
import 'package:audius_flutter_client/components/profile_grid.dart';
import 'package:audius_flutter_client/components/track_card.dart';

class Search extends StatelessWidget {
  Search({required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              // TODO: convert to ListView to improve performance
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            children: [
                              Icon(Icons.account_circle),
                              Text('PROFILES',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            children: [
                              Icon(Icons.music_note),
                              Text('TRACKS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            children: [
                              Icon(Icons.album),
                              Text('ALBUMS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            children: [
                              Icon(Icons.queue_music),
                              Text('PLAYLISTS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ],
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        FutureBuilder(
                          future: Network.searchUser(search),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<User>> snapshot) {
                            Widget body;
                            // print('Initialized userGrids');
                            if (snapshot.hasData) {
                              body = GridView.count(
                                crossAxisCount: 2,
                                children: snapshot.data!
                                    .map((user) => ProfileGrid(user))
                                    .toList(),
                              );
                            } else if (snapshot.hasError) {
                              print('Error: ${snapshot.error}');
                              body = Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text('Error: ${snapshot.error}'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              body = Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 60,
                                      height: 60,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Awaiting result...'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return body;
                          },
                        ),
                        FutureBuilder(
                          future: Network.searchTrack(search),
                          builder:
                              (context, AsyncSnapshot<List<Track>> snapshot) {
                            Widget body;

                            if (snapshot.hasData) {
                              body = ListView(
                                children: snapshot.data!
                                    .map(
                                      (track) => TrackCard(
                                        track,
                                        snapshot.data!.indexOf(track),
                                        snapshot.data!,
                                      ),
                                    )
                                    .toList(),
                              );
                            } else if (snapshot.hasError) {
                              print('Error: ${snapshot.error}');
                              body = Column(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  ),
                                ],
                              );
                            } else {
                              body = Column(
                                children: [
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 60,
                                    height: 60,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Awaiting result...'),
                                  ),
                                ],
                              );
                            }

                            return body;
                          },
                        ),
                        Text('ALBUM'),
                        Text('PLAYLISTS'),
                      ],
                    ),
                  ),
                  Placeholder(
                    color: Colors.transparent,
                    fallbackHeight: 120,
                    fallbackWidth: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
