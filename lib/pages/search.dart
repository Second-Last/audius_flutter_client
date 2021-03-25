import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audius_flutter_client/components/profile_grid.dart';

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
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            Widget body;
                            print('Initialized userGrids');
                            if (snapshot.hasData) {
                              body = GridView.count(
                                crossAxisCount: 2,
                                children: snapshot.data,
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
                          future: gridBuilder(search),
                        ),
                        Text('TRACKS'),
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

// body: FutureBuilder(
//   builder: (BuildContext context, AsyncSnapshot snapshot) {
//     Widget body;
//     print('Initialized userGrids');
//     if (snapshot.hasData) {
//       body = GridView.count(
//         crossAxisCount: 2,
//         children: snapshot.data,
//       );
//     } else if (snapshot.hasError) {
//       print('Error: ${snapshot.error}');
//       body = Column(
//         children: [
//           Icon(
//             Icons.error_outline,
//             color: Colors.red,
//             size: 60,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Text('Error: ${snapshot.error}'),
//           )
//         ],
//       );
//     } else {
//       body = Column(
//         children: [
//           SizedBox(
//             child: CircularProgressIndicator(),
//             width: 60,
//             height: 60,
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 16),
//             child: Text('Awaiting result...'),
//           )
//         ],
//       );
//     }

//     return body;
//   },
//   future: gridBuilder(),
// ),
