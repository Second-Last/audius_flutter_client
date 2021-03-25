// import '../components/fake_app_bar.dart';
import 'package:audius_flutter_client/components/search_integrated.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchIntegratedPage(
      mainContent: Center(
        child: Icon(
          Icons.explore,
          size: 80,
        ),
      ),
    );
  }
}

// Center(
//             child: Icon(
//               Icons.explore,
//               size: 80,
//             ),
//           )

// // TODO: requests the data everytime page changes!
// Future<List<ProfileGrid>> gridBuilder() async {
//   var url = Uri.https('audius-metadata-3.figment.io', 'v1/users/search',
//       {'query': 'Gavin Zhao', 'app name': 'Audius Flutter Client'});
//   print('Current target url: ${url.toString()}');

//   // Await the http get response, then decode the json-formatted response.
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     print('Request finished with status ${response.statusCode}');
//     var jsonResponse = convert.jsonDecode(response.body)['data'];
//     // for (Map user in jsonResponse) {
//     //   print('${user['name']}');
//     // }
//     // print('Hello');
//     return List.from(
//         jsonResponse.map((e) => ProfileGrid(User.fromJson(e))).toList());
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     throw Exception('Request failed with status: ${response.statusCode}.');
//   }
// }

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
