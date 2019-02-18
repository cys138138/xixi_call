import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class CallListLog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CallListLog();
  }
}

class _CallListLog extends State<CallListLog> {
  var phoneLog = [];

  _CallListLog(){
    getCallLog();
  }

  void getCallLog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    var x = [];
    for (var n in entries) {
      var date = new DateTime.fromMicrosecondsSinceEpoch(n.timestamp*1000);
      String dtime = date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()+' '+date.hour.toString()+':'+date.minute.toString()+":"+date.second.toString();
      if(true || n.duration > 0){
        x.add({
          'number': n.number.toString(),
          'name': n.name.toString(),
          'callType': n.callType,
          'duration': n.duration.toString(),
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
        return Column(
          children: <Widget>[
            ListTile(
              onTap: (){
                print(rowInfo);
              },
              title: new Text(rowInfo["number"]),
              subtitle: Text(rowInfo["time"]),
              trailing: Text(rowInfo["duration"]+'s'),
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