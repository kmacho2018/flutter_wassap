import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';


class CallsScreen extends StatelessWidget {
  BannerAd _bannerAd;
InterstitialAd _interstitialAd;

static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
  testDevices: <String>[],
  keywords: <String>['WhatsFake'],
  birthday: new DateTime.now(),
  childDirected: true
);

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

  @override
  Widget build(BuildContext context) {
    try{
    FirebaseAdMob.instance.initialize(appId: "1:878077547789:android:8ae3d1b904a2c5a2");
    
    _bannerAd =  createBannerAd()
    ..load()
    ..show();}catch(e){}
    
    return new Center(
      child: new Text("Call",style: new TextStyle(fontSize: 20.0))
    );
  }
}