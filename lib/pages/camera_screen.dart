import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {

List<CameraDescription> cameras;

CameraScreen(this.cameras);

  @override
  CameraScreenState createState() {
    return new CameraScreenState();
  }
}

class CameraScreenState extends State<CameraScreen> {

  CameraController cameraController;
  @override
    void initState() {
      // TODO: implement initState
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
      child: new CameraPreview(cameraController),
    );
    /*return new Center(
      child: new Text("Camera",style: new TextStyle(fontSize: 20.0))
    );*/
  }
}