import 'dart:async';
import 'dart:convert';

import 'package:call/OsApplication.dart';
import 'package:call/events/LoginEvent.dart';
import 'package:call/pages/CallListLog.dart';
import 'package:call/pages/Login.dart';
import 'package:call/pages/Mine.dart';
import 'package:call/pages/Statistics.dart';
import 'package:call/utils/Api.dart';
import 'package:call/utils/SpUtils.dart';
import 'package:call/utils/TsUtils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xdh_call/xdh_call.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'), // English
        // ... other locales the app supports
      ],
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: '通话列表'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int time = 0;
  Timer _timer;
  var socket = null;
  String uniqueId;
  String reply_uid;
  String client_uid;
  int duraition = 0;

  var token;

  _MyHomePageState() {
    _getUniqueId();
    _initEvent();
    _getUserInfo();
  }

  @override
  void dispose() {
    socket.sink.close();
    stopTime();
    super.dispose();
  }

  void stopTime() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
  }

  void startTime() {
    _timer = new Timer.periodic(const Duration(seconds: 30), (timer) {
      //检测是否在线
      Api.post(Api.CHECK_ONLINE+token,data: {
        'bind_uid': client_uid,
      }).then((res){
        if(res["code"] == 0){
          socket = null;
          initSocket();
          return;
        }else{
          try {
            socket.sink.add('{"type":"ping","data":""}');
          } catch (e) {
            initSocket();
          }
        }
      });

    });
  }


  _getUniqueId() async {
    uniqueId = await XdhCall.getUniqueId();
  }


  initSocket() async {
    if (socket == null) {
      socket = await IOWebSocketChannel.connect(Api.SOCKET_HOST);

      socket.stream.listen((message) {
        var jsonStr = json.decode(message);
        bindSocket(jsonStr);
      });
      if (socket != null) {
        startTime();
      }
    }
  }

  void bindSocket(var jsonStr){
    if(jsonStr['type'] == 'init'){
      Api.post(Api.BIND_UID_URL+token,data: {
        'client_id':jsonStr['client_id'],
        'unique_id': uniqueId,
      }).then((res){
        if(res["code"] == 0){
          TsUtils.showShort(res["msg"]);
          return;
        }
        reply_uid = res["data"]['reply_uid'];
        client_uid = res["data"]['binduid'];
      });
    }
    else if(jsonStr['type'] == 'callphone'){
      XdhCall.callphone("call",is_confirm:false,phone_number:jsonStr['data']['mobile']);
    }
    else if(jsonStr['type'] == 'call_cancel'){
      XdhCall.endCall();
    }
    else if(jsonStr['type'] == 'message'){
      XdhCall.sendSms(phone_number: jsonStr['data']['mobile'],sms_content: jsonStr['data']['content']);
    }
  }

  int _currentIndex = 0; //当前页面索引
  PageController _pageController = new PageController(initialPage: 0);
  var _pageList = <StatefulWidget>[
    new CallListLog(),
//    new Statistics(),
//    new CallListLog(),
    new Mine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new IndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      resizeToAvoidBottomPadding: false,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    BottomNavigationBar _bottomNavigationBar = BottomNavigationBar(
      items: [
        _bottomNavigationBarItem(Icons.home, Icons.home, '通话记录', 0),
//        _bottomNavigationBarItem(Icons.view_list, Icons.filter_list, '通话统计', 1),
//        _bottomNavigationBarItem(Icons.camera, Icons.camera, '我的录音', 2),
        _bottomNavigationBarItem(Icons.person_outline, Icons.person, '我的', 3)
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      fixedColor: Colors.green,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
    return _bottomNavigationBar;
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      IconData icon, IconData activeIcon, String title, int itemIndex) {
    var _bottomNavigationBarColor = Color.fromARGB(255, 166, 166, 166);
    if (_currentIndex == itemIndex) {
      _bottomNavigationBarColor = Colors.green;
    }
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _bottomNavigationBarColor),
        activeIcon: Icon(activeIcon, color: _bottomNavigationBarColor),
        title: Text(title, style: TextStyle(color: _bottomNavigationBarColor)));
  }

  void _initEvent() {
    OsApplication.eventBus.on<LoginEvent>().listen((event) {
      _getUserInfo();
    });

  }

  /**
   * 登录之后
   */
  void _loinAfter(){
    initSocket();
    XdhCall(_onEvent,_onError);
  }



  void getCallLogDuraition(String mobile) async {
    String LogList = await XdhCall.getCallLogByWhere("NUMBER = $mobile", "DATE desc");
    var jsonStr = json.decode(LogList);
    int d = jsonStr[0]["duraition"];
    duraition = d;
  }

  //监听通话状态
//1.初始化
//2.定义回调方法
  void _onEvent(Object event) {
    String str = event.toString().replaceAll("'", '"');
    try{
      var data = json.decode(str);
      print(data);
      String type = data['type'];
      //挂断
      if(data['type'] == 'call_state_idle'){
        type = 'app_call_down_reply';
        getCallLogDuraition(data['phone']);
      }

      //接听
      if(data['type'] == 'call_state_offhook'){
        type = 'app_call_going_reply';
      }
      //呼入响铃
      if(data['type'] == 'call_state_ringing'){
        type = "app_call_in_reply";
      }
      Api.post(Api.REPLAY_URL+token,data: {
        'binduid':client_uid,
        'mobile': data['phone'],
        'type': type,
        'duration': duraition.toString(),
      }).then((result){
        if(result["code"] == 0){
          TsUtils.showShort(result["msg"]);
          return;
        }
      });

    }catch(e){
      print(str);
    }

  }

  void _onError(Object error) {
    print("收到错误");
  }

  _login() async {
    final result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new Login();
    }));
  }

  _getUserInfo() async {
    SpUtils.getUserInfo().then((userInfoBean) {
      if (userInfoBean.token == null) {
        return _login();
      }else{
        setState(() {
          token = userInfoBean.token;
        });
        _loinAfter();
      }
    });
  }
}
