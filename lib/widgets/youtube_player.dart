//import 'package:flutter/material.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
//class YoutubePlayerPage extends StatefulWidget {
//
//  final String videoUrl;
//
//  const YoutubePlayerPage({Key key, @required this.videoUrl}) : super(key: key);
//  @override
//  _YoutubePlayerPageState createState() => _YoutubePlayerPageState();
//}
//
//class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
//
//  YoutubePlayerController _controller;
//
//
//  @override
//  void initState() {
//
//    String videoId;
//
//    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl?? "https://www.youtube.com/watch?v=dJeoD5Sk0PA&list=RDdJeoD5Sk0PA&start_radio=1");
//    print(videoId);
//
//    _controller = YoutubePlayerController(
//      initialVideoId: videoId,
//      flags: YoutubePlayerFlags(
//        autoPlay: true,
//        mute: true,
//      ),
//    );
//
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        child: Center(
//          child: YoutubePlayer(
//            controller: _controller,
//            showVideoProgressIndicator: true,
//          ),
//        ),
//      ),
//    );
//  }
//}
