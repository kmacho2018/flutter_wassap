import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_admob/firebase_admob.dart';


class CameraScreen extends StatefulWidget {

List<CameraDescription> cameras;

CameraScreen(this.cameras);

  @override
  CameraScreenState createState() {
    
    return new CameraScreenState();
  }
}

class CameraScreenState extends State<CameraScreen> {

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



  CameraController cameraController;
  @override
    void initState() {
      // TODO: implement initState
        try{
    FirebaseAdMob.instance.initialize(appId: "1:878077547789:android:8ae3d1b904a2c5a2");
    
    _bannerAd =  createBannerAd()
    ..load()
    ..show();
    
  
    }catch(e){}
      super.initState();
      cameraController  = new CameraController(widget.cameras[0], ResolutionPreset.low);
      cameraController.initialize().then((_){
        if(!mounted){
          return ;
        }

        setState(() {
                  
                });
      });
    }

  @override
    void dispose() {
      // TODO: implement dispose
      _bannerAd.dispose();
      cameraController?.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    if(!cameraController.value.isInitialized){
      return new Container();
    }
    return new AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: new CameraPreview(cameraController)
    );
    /*return new Center(
      child: new Text("Camera",style: new TextStyle(fontSize: 20.0))
    );*/
  }
}