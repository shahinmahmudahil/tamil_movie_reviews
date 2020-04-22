import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:moviereviews/widgets/cached_network_image_widget.dart';
import 'package:moviereviews/models/article.dart';
import 'package:moviereviews/widgets/youtube_player.dart';
import 'package:share/share.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dashboard_page.dart';

class SingleArticle extends StatefulWidget {
  final String herotag;
  final Article article;

  const SingleArticle({Key key, this.herotag, @required this.article}) : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {


/////////  native ads ///////////
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;
  String videoId;


  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);



//    videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=dJeoD5Sk0PA&list=RDdJeoD5Sk0PA&start_radio=1");
//    print(videoId);

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 330;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  //Flare soccer
      Center(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Hero(
                  tag: widget.herotag,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedImgWithError(
                      imgUrl: widget.article.imgUrl,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.article.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,

                    ),),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.article.body.substring(0,(widget.article.body.length/2).round()),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          wordSpacing: 1,

                        ),
                         textAlign: TextAlign.start,
                        ),
                    ),
                  ),
                ),

                Container(
                  height: _height,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    // Your ad unit id
                    adUnitID: nativeAdId,
                    controller: _nativeAdController,

                    // Don't show loading widget when in loading state
                    loading: Container(),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.article.body.substring((widget.article.body.length/2).round(),widget.article.body.length),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          wordSpacing: 1,

                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                          onTap: (){
                            Share.share('https://play.google.com/store/apps/details?id=com.fliitt.moviereviews');
                          },
                          child: Icon(Icons.share,size: 44,color: Colors.green,)),
                    ),
                  ],
                ),

              /*  GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> YoutubePlayerPage()));
                  },
                  child: Stack(
                    children: <Widget>[

                      Image.network(
                            YoutubePlayer.getThumbnail(
                              videoId: videoId
                            ),
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) => progress == null
                            ? child
                            : Container(
                          color: Colors.black,
                        ),
                      ),

                      Positioned(
                        left: 100,
                        bottom: 100,
                        child: Icon(Icons.play_arrow,color: Colors.red,size: 144,),
                      ),
                    ],
                  ),
                ),*/

                Container(
                  height: _height,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    // Your ad unit id
                    adUnitID: nativeAdId,
                    controller: _nativeAdController,


                    // Don't show loading widget when in loading state
                    loading: Container(),
                  ),
                ),

                SizedBox(height: 150,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
