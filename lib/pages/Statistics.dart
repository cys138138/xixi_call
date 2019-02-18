import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Statistics();
  }
}

class _Statistics extends State<Statistics> {
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
                                  "2019年",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "2月",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
                                  "总电话数",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "141",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
                                  "04:01",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
                border: Border(bottom: BorderSide(color:Colors.grey))
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: Text("日期"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("通话数量", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("累计时长", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("60s以下", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),

                  Expanded(
                    child: Center(child: Text("60-180s", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("180-360s", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("360s以上", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.0),),),
                    flex: 1,
                  ),
                ],
              ),
            ),

            Expanded(
              child:
              ListView.builder(itemBuilder: (ctx, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(child: Text("A1"),),
                            flex: 1,
                          ),

                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color:Colors.grey[400])),
                      ),
                      height: 40.0,
                    ),
                  ],
                );
              },
                itemCount: 200,
              ),
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.grey[100]
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: Text("总计"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0.00"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0"),),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(child: Text("0"),),
                    flex: 1,
                  ),

                ],
              ),
            )

          ],
        ));
  }
}
