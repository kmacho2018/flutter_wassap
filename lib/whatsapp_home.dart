import 'package:flutter/material.dart';
import 'pages/call_screen.dart';
import 'pages/camera_screen.dart';
import 'pages/chat_screen.dart';
import 'pages/status_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';


class WhatsAppHome extends StatefulWidget {
   var cameras;
   WhatsAppHome(this.cameras);
  @override
  _WhatsAppHomeState createState() => new _WhatsAppHomeState();
}


class _WhatsAppHomeState extends State<WhatsAppHome> with SingleTickerProviderStateMixin {

TabController _tabController;

static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
  testDevices: <String>[],
  keywords: <String>['WhatsFake'],
  birthday: new DateTime.now(),
  childDirected: true
);

BannerAd _bannerAd;
InterstitialAd _interstitialAd;

BannerAd createBannerAd(){
  return new BannerAd(
    adUnitId: "ca-app-pub-5481418231019020/2280278018",
    size: AdSize.banner,
    targetingInfo: targetInfo,
    listener: (MobileAdEvent event){
      print("Banner event: $event");
    }
  );
}
InterstitialAd createInterstitialAd(){
  return new InterstitialAd(
    adUnitId:  "ca-app-pub-5481418231019020/5968285434",
    targetingInfo: targetInfo,
    listener: (MobileAdEvent event){
      print("Interstitial event: $event");
    }
  );
}

void showAds(){
  _bannerAd =  createBannerAd()
    ..load()
    ..show();

  
}



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
    FirebaseAdMob.instance.initialize(appId: "1:878077547789:android:8ae3d1b904a2c5a2");
    _interstitialAd =  createInterstitialAd()
    ..load()
    ..show(
       anchorOffset: 0.0,
      anchorType: AnchorType.bottom);
    _tabController = new TabController(vsync: this,initialIndex: 1,length: 4);
    }catch(ex){}
  }

  @override void dispose() {
      // TODO: implement dispose
      _bannerAd.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WhatsApp"),
        elevation: 0.7,
        bottom:  new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.camera_alt)),
            new Tab(text: "CHATS  "),
            new Tab(text: "STATUS"),
            new Tab(text: "CALLS")
          ],
        ),
        actions: <Widget>[new Icon(Icons.search), new Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5.0),
        ) ,new Icon(Icons.more_vert)],
      ),
      body: new TabBarView(
        controller:  _tabController,
        children: <Widget>[
          new CameraScreen(widget.cameras),
          new ChatScreen(),
          new StatusScreen(),
          new CallsScreen()
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: new Icon(Icons.message, color:Colors.white),
        
        onPressed: ()=> showAds(),
    ));
  }
}