import 'package:call/utils/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';

class Statistics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Statistics();
  }
}

class _Statistics extends State<Statistics> {
  var dataList = [];
  var year = '2019';
  var month = '2';
  var all_count = '141';
  var all_duration = '04:01';
  var this_count = '0';
  var this_duration = '0';
  var this_t60 = '0';
  var this_t60_180 = '0';
  var this_t180_360 = '0';
  var this_t360 = '0';

  _Statistics() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("数据统计"),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[400])),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: DateTime.parse("2018-10-01"),
                              lastDate: DateTime.parse("2020-10-01")
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Colors.grey))),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  year + "年",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  month + "月",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )),
                          height: 55.0,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.grey))),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "总电话数",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              all_count,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                      height: 55.0,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.grey))),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "总通话数",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              all_duration,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                      height: 55.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("日期"),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "通话数量",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "累计时长",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "60s以下",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "60-180s",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "180-360s",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "360s以上",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Refresh(
                onFooterRefresh: onFooterRefresh,
                onHeaderRefresh: onHeaderRefresh,
                childBuilder: (BuildContext context,
                    {ScrollController controller, ScrollPhysics physics}) {
                  return new Container(
                      child: new ListView.builder(
                    physics: physics,
                    controller: controller,
                    itemBuilder: _itemBuilder,
                    itemCount: dataList.length,
                  ));
                },
              ),
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("总计"),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_count),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_duration == '0'
                          ? '00:00'
                          : getTimeStr(int.parse(this_duration))),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_t60),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_t60_180),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_t180_360),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(this_t360),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void getData() {
    Api.post(Api.GET_CALL_STATISTICS, data: {
      'ipt-year': year,
      'ipt-month': month,
    }).then((result) {
      if (result['code'] == 1) {
        setState(() {
          dataList = result['list'];
          this_count = result['this_count'].toString();
          this_duration = result['this_duration'].toString();
          this_t60 = result['this_t60'].toString();
          this_t60_180 = result['this_t60_180'].toString();
          this_t180_360 = result['this_t180_360'].toString();
          this_t360 = result['this_t360'].toString();
          all_count = result['all_count'].toString();
          all_duration = result['all_duration'] == 0
              ? '00:00'
              : getTimeStr(int.parse(result['all_duration']));
        });
      }
    });
  }

  String getTimeStr(int second) {
    if (second < 1) {
      return '0';
    }
    double hour = second / 3600;
    double minute = (second - (hour.toInt() * 3600)) / 60;
    String shour =
        hour < 10 ? '0' + hour.toInt().toString() : hour.toInt().toString();
    String sminute = minute.ceil() < 10
        ? '0' + minute.ceil().toString()
        : minute.ceil().toString();
    return shour + ':' + sminute;
  }

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        getData();
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        getData();
      });
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var row = dataList[index];
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(row['date'].toString() + '日'),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['count'].toString()),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['duration'] == 0
                      ? '00:00'
                      : getTimeStr(row['duration'])),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['t60'].toString()),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['t60_180'].toString()),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['t180_360'].toString()),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                  child: Text(row['t360'].toString()),
                ),
                flex: 1,
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400])),
          ),
          height: 40.0,
        ),
      ],
    );
  }
}
