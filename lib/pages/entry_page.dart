import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:launch_review/launch_review.dart';
import 'package:moviereviews/pages/about.dart';
import 'package:moviereviews/widgets/tap_action.dart';
import 'package:share/share.dart';
import 'dashboard_page.dart';


class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  /////////  native ads ///////////
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;


  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);

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
          _height = 300;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            SizedBox(height: 44,),

//            Container(
//              height: 50,
//              padding: EdgeInsets.all(10),
//              margin: EdgeInsets.only(bottom: 20.0),
//              child: NativeAdmob(
//                // Your ad unit id
//                adUnitID: nativeAdId,
//                controller: _nativeAdController,
//
//                // Don't show loading widget when in loading state
//                loading: Container(),
//              ),
//            ),

            SizedBox(height: 44,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TapAction(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PageDashboard()));
                  },
                  child: Card(
                    elevation: 22,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: const EdgeInsets.symmetric(vertical: 44),
                      child: Column(
                        children: <Widget>[

                          Image.asset("assets/aa.png",
                            width: 90,

                          ),

                          Text("Tamil Movie",
                            style: TextStyle(
                            fontSize: 38,
                            color: Colors.black,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height: 34,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                TapAction(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AboutPage()));
                  },
                  child: Card(
                    elevation: 22,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.25,
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.assistant_photo,
                            size: 34,
                            color: Colors.green,
                          ),
                          Text("About",
                            style: TextStyle(

                              color: Colors.black,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),

                TapAction(
                  onTap: (){

                    ////////       Share url   //////////
                    Share.share('https://play.google.com/store/apps/details?id=com.fliitt.moviereviews');
                  },
                  child: Card(
                    elevation: 22,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.25,
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            size: 34,
                            color: Colors.purple,
                          ),
                          Text("Share",
                            style: TextStyle(

                              color: Colors.black,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),

                TapAction(
                  onTap: (){
                    rateApp();
                  },
                  child: Card(
                    elevation: 22,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.25,
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.star_half,
                            size: 34,
                            color: Colors.yellow,
                          ),
                          Text("Rate",
                            style: TextStyle(

                              color: Colors.black,
                            ),),

                        ],

                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 34,),

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
          ],
        ),
      ),
    );
  }

  void rateApp() {
    LaunchReview.launch(androidAppId: "com.fliitt.moviereviews",
        iOSAppId: "585027354");
  }
}
