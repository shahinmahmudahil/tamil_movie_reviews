import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:moviereviews/widgets/cached_network_image_widget.dart';
import 'package:moviereviews/models/article.dart';
import 'package:share/share.dart';

class AboutPage extends StatefulWidget {


  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {



  @override
  void initState() {


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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


                Text(
                  "Ultimate Collection of Tamil Hit Movie, Tamil Songs, Video Songs, Latest Tamil Songs, Romantic Tamil Songs, Old Tamil Songs in a Single Application. Tamil Latest New Movies and Old Movie For 2019 for you can Tamil New movies download 2019 and Tamil Old movies download this application for Tamil New movies, and Tamil movies download ",
                  style: TextStyle(
                    fontSize: 20,

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

                SizedBox(height: 150,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
