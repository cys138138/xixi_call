import 'dart:async';

import 'package:call/OsApplication.dart';
import 'package:call/events/LoginEvent.dart';
import 'package:call/pages/CallListLog.dart';
import 'package:call/pages/Login.dart';
import 'package:call/pages/Mine.dart';
import 'package:call/pages/Statistics.dart';
import 'package:call/utils/Api.dart';
import 'package:call/utils/SpUtils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  _MyHomePageState() {
    initSocket();
    _initEvent();
    _getUserInfo();
  }

  @override
  void dispose() {
    print("应用销毁");
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
      try {
        socket.sink.add("client send ping");
      } catch (e) {
        initSocket();
        print("重新初始化");
      }
    });
  }

  var socket = null;

  initSocket() async {
    if (socket == null) {
      socket = await IOWebSocketChannel.connect(Api.SOCKET_HOST);
      socket.stream.listen((message) {
        print(message);
      });
      if (socket != null) {
        startTime();
      }
    }
  }

  int _currentIndex = 0; //当前页面索引
  PageController _pageController = new PageController(initialPage: 0);
  var _pageList = <StatefulWidget>[
    new CallListLog(),
    new Statistics(),
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
        _bottomNavigationBarItem(Icons.view_list, Icons.filter_list, '通话统计', 1),
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

  _login() async {
    final result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new Login();
    }));
  }

  _getUserInfo() async {
    print("获取用户信息");
    SpUtils.getUserInfo().then((userInfoBean) {
      print(userInfoBean.token);
      if (userInfoBean.token == null) {
        return _login();
      }
    });
  }
}
