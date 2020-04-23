import 'dart:async';
import 'dart:io';

import 'package:ads/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:moviereviews/models/article.dart';
import 'package:moviereviews/pages/firestore_test.dart';
import 'package:moviereviews/pages/single_article.dart';
import 'package:moviereviews/widgets/bg_scaffold.dart';
import 'package:moviereviews/widgets/cached_network_image_widget.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:share/share.dart';

/// Made a high-level variable to be accessible to ads_test.dart
Ads ads;

final String appId =
    Platform.isAndroid ? 'ca-app-pub-2304800397905456~6935494460' : 'ca-app-pub-3940256099942544~1458002511';
final String bannerUnitId =
    Platform.isAndroid ? 'ca-app-pub-2304800397905456/5622412793' : 'ca-app-pub-3940256099942544/2934735716';
final String screenUnitId =
    Platform.isAndroid ? 'ca-app-pub-2304800397905456/2996249456' : 'ca-app-pub-3940256099942544/4411468910';
final String videoUnitId =
    Platform.isAndroid ? 'ca-app-pub-2304800397905456/2996249456' : 'ca-app-pub-3940256099942544/1712485313';

final String nativeAdId =
    Platform.isAndroid ? 'ca-app-pub-2304800397905456/8200474676' : 'ca-app-pub-3940256099942544/1712485313';

//#Android
//Admob android app id -> ca-app-pub-2416770986772858~4913966824
//test app id -> 'ca-app-pub-3940256099942544~3347511713'
//interstitial -> ca-app-pub-2416770986772858/8382438541
//banner -> ca-app-pub-2416770986772858/9783150121
//reward -> ca-app-pub-2416770986772858/9759099394

//#IOS
//IOs app id -> ca-app-pub-2416770986772858~5090539728
//ios test app id -> ca-app-pub-3940256099942544~1458002511
//ios banner -> ca-app-pub-2416770986772858/4364422044
//ios interstatial -> ca-app-pub-2416770986772858/3585886368
//ios reward -> ca-app-pub-2416770986772858/3394314679

class PageDashboard extends StatefulWidget {
  @override
  _PageDashboardState createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  int _selectedIndex = 0;
  int initOption = 1;
  int _coins = 0;


  @override
  void initState() {
    super.initState();
    adSetup();
  }

  @override
  void dispose() {
    ads?.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[

            NewsFeeds(),
//            ListView.builder(
//                itemCount: 3,
//                itemBuilder: (context,index){
//                  return Text("g3");
//                }),
//
//            PageBusList(),
//
//            //Flare soccer
//            Align(
//              alignment: Alignment.topCenter,
//              child:  Container(
//                padding: EdgeInsets.only(top: 20),
//                width: 500,
//                height: 500,
//                child: Center(
//                  child: FlareActor(
//                    "assets/flares/soccer.flr",
//                    animation: "ball-jump",
//
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),

//        bottomNavigationBar: BottomNavigationBar(
//          type: BottomNavigationBarType.fixed,
//          items: const <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Icon(Icons.flash_on),
//              title: Text('News'),
//            ),
////            BottomNavigationBarItem(
////              icon: Icon(Icons.thumb_up),
////              title: Text('Liked'),
////            ),
////
////            BottomNavigationBarItem(
////              icon: Icon(Icons.bookmark),
////              title: Text('Saved'),
////            ),
////
////            BottomNavigationBarItem(
////              icon: Icon(Icons.notifications_active),
////              title: Text('Notifications'),
////            ),
//
//          ],
//          currentIndex: _selectedIndex,
//          selectedItemColor: Colors.green[800],
//          elevation: 5,
//
//          onTap: _onItemTapped,
//        )
    );
  }

  ////////////////////// Ads setup ////////////////////
  void adSetup() {
    switch (initOption) {
      case 1:

        /// Assign a listener.
        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.clicked) {
            print("The opened ad is clicked on.");
          }
        };

        ads = Ads(
          appId,
          bannerUnitId: bannerUnitId,
          screenUnitId: screenUnitId,
          videoUnitId: videoUnitId,
          keywords: <String>['Tamil', 'Movies','Entertainment', 'Songs'],
          contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
          childDirected: false,
          testDevices: ['WAS LX2J'],
          testing: false,
          listener: eventListener,
        );

        break;

      case 2:
        ads = Ads(appId);

        /// Assign the listener.
        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.closed) {
            print("User has opened and now closed the ad.");
          }
        };

        /// You can set the Banner, Fullscreen and Video Ads separately.

        ads.setBannerAd(
          adUnitId: bannerUnitId,
          size: AdSize.banner,
          keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
          contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
          childDirected: false,
          testDevices: [''],
          listener: eventListener,
        );

        ads.setFullScreenAd(
            adUnitId: screenUnitId,
            keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
            contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
            childDirected: false,
            testDevices: [''],
            listener: (MobileAdEvent event) {
              if (event == MobileAdEvent.opened) {
                print("An ad has opened up.");
              }
            });

        var videoListener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
          if (event == RewardedVideoAdEvent.rewarded) {
            print("The video ad has been rewarded.");
          }
        };

        ads.setVideoAd(
          adUnitId: videoUnitId,
          keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
          contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
          childDirected: true,
          testDevices: null,
          listener: videoListener,
        );

        break;

      case 3:
        ads = Ads(appId);

        /// Assign the listener.
        var eventListener = (MobileAdEvent event) {
          if (event == MobileAdEvent.closed) {
            print("User has opened and now closed the ad.");
          }
        };

        /// You just show the Banner, Fullscreen and Video Ads separately.

        ads.showBannerAd(
          adUnitId: bannerUnitId,
          size: AdSize.banner,
          keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
          contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
          childDirected: false,
          testDevices: [''],
          listener: eventListener,
        );

        ads.showFullScreenAd(
            adUnitId: screenUnitId,
            keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
            contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
            childDirected: false,
            testDevices: [''],
            listener: (MobileAdEvent event) {
              if (event == MobileAdEvent.opened) {
                print("An ad has opened up.");
              }
            });

        var videoListener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
          if (event == RewardedVideoAdEvent.rewarded) {
            print("The video ad has been rewarded.");
          }
        };

        ads.showVideoAd(
          adUnitId: videoUnitId,
          keywords: ['Tamil', 'Movies','Entertainment', 'Songs'],
          contentUrl: 'https://timesofindia.indiatimes.com/entertainment/tamil/movie-reviews',
          childDirected: true,
          testDevices: null,
          listener: videoListener,
        );

        break;

      default:
        ads = Ads(appId, testing: true);
    }

    ads.eventListener = (MobileAdEvent event) {
      switch (event) {
        case MobileAdEvent.loaded:
          print("An ad has loaded successfully in memory.");
          break;
        case MobileAdEvent.failedToLoad:
          print("The ad failed to load into memory.");
          break;
        case MobileAdEvent.clicked:
          print("The opened ad was clicked on.");
          break;
        case MobileAdEvent.impression:
          print("The user is still looking at the ad. A new ad came up.");
          break;
        case MobileAdEvent.opened:
          print("The Ad is now open.");
          break;
        case MobileAdEvent.leftApplication:
          print("You've left the app after clicking the Ad.");
          break;
        case MobileAdEvent.closed:
          print("You've closed the Ad and returned to the app.");
          break;
        default:
          print("There's a 'new' MobileAdEvent?!");
      }
    };

    MobileAdListener eventHandler = (MobileAdEvent event) {
      print("This is an event handler.");
    };

    ads.bannerListener = (MobileAdEvent event) {
      switch (event) {
        case MobileAdEvent.loaded:
          print("An ad has loaded successfully in memory.");
          break;
        case MobileAdEvent.failedToLoad:
          print("The ad failed to load into memory.");
          break;
        case MobileAdEvent.clicked:
          print("The opened ad was clicked on.");
          break;
        case MobileAdEvent.impression:
          print("The user is still looking at the ad. A new ad came up.");
          break;
        case MobileAdEvent.opened:
          print("The Ad is now open.");
          break;
        case MobileAdEvent.leftApplication:
          print("You've left the app after clicking the Ad.");
          break;
        case MobileAdEvent.closed:
          print("You've closed the Ad and returned to the app.");
          break;
        default:
          print("There's a 'new' MobileAdEvent?!");
      }
    };

    ads.removeBanner(eventHandler);

    ads.removeEvent(eventHandler);

    ads.removeScreen(eventHandler);

    ads.screenListener = (MobileAdEvent event) {
      switch (event) {
        case MobileAdEvent.loaded:
          print("An ad has loaded successfully in memory.");
          break;
        case MobileAdEvent.failedToLoad:
          print("The ad failed to load into memory.");
          break;
        case MobileAdEvent.clicked:
          print("The opened ad was clicked on.");
          break;
        case MobileAdEvent.impression:
          print("The user is still looking at the ad. A new ad came up.");
          break;
        case MobileAdEvent.opened:
          print("The Ad is now open.");
          break;
        case MobileAdEvent.leftApplication:
          print("You've left the app after clicking the Ad.");
          break;
        case MobileAdEvent.closed:
          print("You've closed the Ad and returned to the app.");
          break;
        default:
          print("There's a 'new' MobileAdEvent?!");
      }
    };

    ads.videoListener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      switch (event) {
        case RewardedVideoAdEvent.loaded:
          print("An ad has loaded successfully in memory.");
          break;
        case RewardedVideoAdEvent.failedToLoad:
          print("The ad failed to load into memory.");
          break;
        case RewardedVideoAdEvent.opened:
          print("The ad is now open.");
          break;
        case RewardedVideoAdEvent.leftApplication:
          print("You've left the app after clicking the Ad.");
          break;
        case RewardedVideoAdEvent.closed:
          print("You've closed the Ad and returned to the app.");
          break;
        case RewardedVideoAdEvent.rewarded:
          print("The ad has sent a reward amount.");
          break;
        case RewardedVideoAdEvent.started:
          print("You've just started playing the Video ad.");
          break;
        case RewardedVideoAdEvent.completed:
          print("You've just finished playing the Video ad.");
          break;
        default:
          print("There's a 'new' RewardedVideoAdEvent?!");
      }
    };

    VoidCallback handlerFunc = () {
      print("The opened ad was clicked on.");
    };

    ads.banner.loadedListener = () {
      print("An ad has loaded successfully in memory.");
    };

    ads.banner.removeLoaded(handlerFunc);

    ads.banner.failedListener = () {
      print("An ad failed to load into memory.");
    };

    ads.banner.removeFailed(handlerFunc);

    ads.banner.clickedListener = () {
      print("The opened ad is clicked on.");
    };

    ads.banner.removeClicked(handlerFunc);

    ads.banner.impressionListener = () {
      print("The user is still looking at the ad. A new ad came up.");
    };

    ads.banner.removeImpression(handlerFunc);

    ads.banner.openedListener = () {
      print("You've closed an ad and returned to your app.");
    };

    ads.banner.removeOpened(handlerFunc);

    ads.banner.leftAppListener = () {
      print("You left the app and gone to the ad's website.");
    };

    ads.banner.removeLeftApp(handlerFunc);

    ads.banner.closedListener = () {
      print("You've closed an ad and returned to your app.");
    };

    ads.banner.removeClosed(handlerFunc);

    ads.screen.loadedListener = () {
      print("An ad has loaded into memory.");
    };

    ads.screen.removeLoaded(handlerFunc);

    ads.screen.failedListener = () {
      print("An ad has failed to load in memory.");
    };

    ads.screen.removeFailed(handlerFunc);

    ads.screen.clickedListener = () {
      print("The opened ad was clicked on.");
    };

    ads.screen.removeClicked(handlerFunc);

    ads.screen.impressionListener = () {
      print("You've clicked on a link in the open ad.");
    };

    ads.screen.removeImpression(handlerFunc);

    ads.screen.openedListener = () {
      print("The ad has opened.");
    };

    ads.screen.removeOpened(handlerFunc);

    ads.screen.leftAppListener = () {
      print("The user has left the app and gone to the opened ad.");
    };

    ads.screen.leftAppListener = handlerFunc;

    ads.screen.closedListener = () {
      print("The ad has been closed. The user returns to the app.");
    };

    ads.screen.removeClosed(handlerFunc);

    ads.video.loadedListener = () {
      print("An ad has loaded in memory.");
    };

    ads.video.removeLoaded(handlerFunc);

    ads.video.failedListener = () {
      print("An ad has failed to load in memory.");
    };

    ads.video.removeFailed(handlerFunc);

    ads.video.clickedListener = () {
      print("An ad has been clicked on.");
    };

    ads.video.removeClicked(handlerFunc);

    ads.video.openedListener = () {
      print("An ad has been opened.");
    };

    ads.video.removeOpened(handlerFunc);

    ads.video.leftAppListener = () {
      print("You've left the app to view the video.");
    };

    ads.video.leftAppListener = handlerFunc;

    ads.video.closedListener = () {
      print("The video has been closed.");
    };

    ads.video.removeClosed(handlerFunc);

    ads.video.rewardedListener = (String rewardType, int rewardAmount) {
      print("The ad was sent a reward amount.");
      setState(() {
        _coins += rewardAmount;
      });
    };

    RewardListener rewardHandler = (String rewardType, int rewardAmount) {
      print("This is the Rewarded Video handler");
    };

    ads.video.removeRewarded(rewardHandler);

    ads.video.startedListener = () {
      print("You've just started playing the Video ad.");
    };

    ads.video.removeStarted(handlerFunc);

    ads.video.completedListener = () {
      print("You've just finished playing the Video ad.");
    };

    ads.video.removeCompleted(handlerFunc);

    // Uncomment and run this example
//    List<String> one = ads.keywords;
//
//    String two = ads.contentUrl;
//
//    bool three = ads.childDirected;
//
//    List<String> four = ads.testDevices;
//
//    bool five = ads.initialized;

//    ads.showBannerAd(state: this, anchorOffset: null);
  }
}

////////////////////////////////////////  News Feeds ///////////////////////
class NewsFeeds extends StatefulWidget {
  @override
  _NewsFeedsState createState() => _NewsFeedsState();
}

class _NewsFeedsState extends State<NewsFeeds> {
/////////  native ads ///////////
  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;
  List<Article> articles = List();

  List itemListWithAd = List();

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);

    getFirebaseData();

    ///===Listen to data change at the collection and call the listener function
    Firestore.instance.collection('Articles').snapshots().listen(_onDataChange);

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void getFirebaseData() async {
    Firestore.instance.collection('Articles').snapshots().listen((data) {
      data.documents.forEach((document) {
        final article = Article.fromSnapshot(document);
        articles.add(article);
      });

      /////////// Add native ads in between ////////
      setState(() {

        // TODO Reveresed to show latest on top
        articles = articles.reversed.toList();

        //        articles.insert(0, null);
        int len = articles.length;

        for(int k =0 ;k<articles.length;k++){
          if(k%3==0)
            articles.insert(k, null);
        }
        articles.insert(articles.length, null);

        print(articles.length);
      });
    });
  }

  void _onDataChange(QuerySnapshot snapshot) {
    print(snapshot);
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
    return articles != null || articles.length > 0
        ? ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              if (articles[index] == null)
                return Container(
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
                );
              else
                return SingleCard(article: articles[index]);
            })
        : Center(
            child: CircularProgressIndicator(),
          );

//      StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('Articles').snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        List<Article> articles = List();
//
//        snapshot.data.documents.forEach((document){
//          final article = Article.fromSnapshot(document);
//          articles.add(article);
//        });
//
//        if (snapshot.hasError)
//          return new Text('Error: ${snapshot.error}');
//        switch (snapshot.connectionState) {
//          case ConnectionState.waiting: return  Center(child: Text('Loading...'));
//          default:
//            return  ListView.builder(
//                itemCount: articles.length+2,
//                itemBuilder: (context,index){
//                  if(index==2 || index==4)
//                    return Container(
//                      height: _height,
//                      padding: EdgeInsets.all(10),
//                      margin: EdgeInsets.only(bottom: 20.0),
//                      child: NativeAdmob(
//                        // Your ad unit id
//                        adUnitID: nativeAdId,
//                        controller: _nativeAdController,
//
//                        // Don't show loading widget when in loading state
//                        loading: Container(),
//
//                      ),
//                    );
//                  else
//                    return SingleCard(article: articles[index]);
//            });
//
//        }
//      },
//    );
  }
}


////////////////////// Single element ////////////////////////
class SingleCard extends StatefulWidget {
  final Article article;

  const SingleCard({Key key, @required this.article}) : super(key: key);

  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ////Show full screen ad

        ads.showFullScreenAd(state: this).then((x) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SingleArticle(
                herotag: "img-article-${widget.article.title}",
                article: widget.article,
              )));
        });
      },
      child: Card(
          elevation: 2,
          child: Column(
            children: <Widget>[
              Hero(
                tag: "img-article-${widget.article.title}",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedImgWithError(
                    imgUrl: widget.article.imgUrl,
                  ),
                ),
              ),

//

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.article.body,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Icon(
                      Icons.bookmark_border,
                      size: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                          onTap: () {
                            Share.share('https://play.google.com/store/apps/details?id=com.fliitt.moviereviews');
                          },
                          child: Icon(
                            Icons.share,
                            size: 22,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
