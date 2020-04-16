import 'package:flutter/material.dart';
import 'package:moviereviews/pages/splashscreen.dart';
import 'package:moviereviews/widgets/youtube_player.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamil movies ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
//      home: PageDashboard(),
      home: SplashScreen(),
//    home: YoutubePlayerPage(),
    );
  }
}

