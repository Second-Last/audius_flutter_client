import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:audio_service/audio_service.dart';

import 'home.dart';
import 'package:audius_flutter_client/services/network.dart';
import 'constants.dart';


void main() {
  // It's okay to not use async
  // Because the time to load is greater than the time to fetch hosts
  Network.setHost();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audius Local',
      theme: ThemeData(
        primarySwatch: audiusColor,
        fontFamily: 'Avenir Next LT Pro',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          // shadowColor: Colors.transparent,
          centerTitle: true,
          toolbarTextStyle: TextStyle(color: audiusColor),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: audiusGrey,
          labelStyle: TextStyle(color: audiusGrey, fontSize: 12),
          unselectedLabelColor: audiusLightGrey,
          unselectedLabelStyle: TextStyle(color: audiusLightGrey, fontSize: 12),
        ),
      ),
      home: AudioServiceWidget(child: BlocWrapped()),
    );
  }
}

