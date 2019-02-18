import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

// 资讯列表页面
class Audio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AudioState();
  }
}

class AudioState extends State<Audio> {
  AudioPlayer audioPlayer;
  static const platform = const MethodChannel("com.flyou.test/android");

  start() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    bool hasPermissions = await AudioRecorder.hasPermissions;
    print(hasPermissions);
    bool isRecording = await AudioRecorder.isRecording;
    if(isRecording){
      return print("正在录音中");
    }
    File file = new File(tempPath+'/abc.m4a');
    file.delete();
    // Start recording
    await AudioRecorder.start(path: tempPath+'/abc', audioOutputFormat: AudioOutputFormat.AAC);
  }
  stop() async {
    bool isRecording = await AudioRecorder.isRecording;
    if(!isRecording){
      return print("没有正在录音");
    }
    Recording recording = await AudioRecorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('录音'),

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new FlatButton(onPressed: (){
              start();
            }, child: new Text("开始录音")
            ),
            new FlatButton(onPressed: (){
              stop();
            }, child: new Text("停止")
            ),
            new FlatButton(onPressed: (){
              show();
            }, child: new Text("显示文件")
            ),new FlatButton(onPressed: (){
              play();
            }, child: new Text("播放")
            ),
            new FlatButton(onPressed: (){
              playStop();
            }, child: new Text("暂停")
            ),
            new FlatButton(onPressed: (){
              callPhone("15807657230");
            }, child: new Text("打电话")
            )
          ],
        ),
      ),
    );
    // TODO: implement build
  }

  show() async {
    List<FileSystemEntity> files = [];
    Directory tempDir = await getTemporaryDirectory();
    String sDCardDir = tempDir.path;
    var directory = Directory(sDCardDir);
    files = directory.listSync();
    for(int i=0;i<files.length;i++){
      print(files[i]);
    }
  }

  play() async {
    Directory tempDir = await getTemporaryDirectory();
    String sDCardDir = tempDir.path;
    audioPlayer = new AudioPlayer();
    int result = await audioPlayer.play(sDCardDir+'/abc.m4a', isLocal: true);
    print(result);
  }
  playStop() async {
    audioPlayer.stop();
  }
  _launchURL() async {
    const url = 'tel://15807657230';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  callPhone(String msg) async {
    try {
      await platform.invokeMethod("callphone",{"mobile":msg});
    } on PlatformException catch (e) {
      print(e.toString());
    }

  }

}