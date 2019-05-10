import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xdh_call/xdh_call.dart';

class CallListLog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CallListLog();
  }
}

class _CallListLog extends State<CallListLog> {
  var phoneLog = [];

  _CallListLog(){
    phoneLog = [];
    getCallLog();
  }


  void getCallLog() async {
    String LogList = await XdhCall.getCallLog();
    var jsonStr = json.decode(LogList);
    print(jsonStr);
    var x = [];
    for (var n in jsonStr) {
      var date = new DateTime.fromMillisecondsSinceEpoch(n["date"]);
      String dtime = "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

      if(true || n.duration > 0){
        x.add({
          'number': n["number"],
          'name': n["number"],
          'callType': n["type"],
          'duration': n["duraition"],
          'time': dtime,
        });
      }

    }
    setState(() {
      phoneLog = x;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget _body;
    if(phoneLog.length == 0){
      _body = new Center(
        child: new CircularProgressIndicator(
          backgroundColor: Colors.green,
        ),
      );
    }else{
      _body = ListView.builder(itemBuilder: (cxt,index){
        var rowInfo = phoneLog[index];
        print(rowInfo);
        return Column(
          children: <Widget>[
            ListTile(
              onTap: (){
                print(rowInfo);
              },
              title: new Text(rowInfo["number"].toString()),
              subtitle: Text(rowInfo["time"].toString()),
              trailing: Text(rowInfo["duration"].toString()+'s'),
            ),
            new Divider(height: 1.0)
          ],
        );
      },
        itemCount: phoneLog.length,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("通话统计"),),
      ),
      body: _body,
    );
  }
}