import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:moviereviews/pages/dashboard_page.dart';
import 'package:moviereviews/pages/entry_page.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EntryPage()));
    });
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            Container(
//              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+50),
//              width: 300,
//              height: 300,
//              child: Center(
//                child: FlareActor(
//                  "assets/flares/soccer.flr",
//                  animation: "ball-jump",
//
//                ),
//              ),
//            ),

            Text(
              "Tamil Movies",
              style: TextStyle(
                fontSize: 34,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
