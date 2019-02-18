import 'package:call/pages/CallListLog.dart';
import 'package:call/pages/Login.dart';
import 'package:call/pages/Statistics.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  int _currentIndex = 0; //当前页面索引
  PageController _pageController = new PageController(initialPage: 0);
  var _pageList = <StatefulWidget>[
    new CallListLog(),
    new Statistics(),
    new Login(),
    new Login(),
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
        _bottomNavigationBarItem(Icons.camera, Icons.camera, '我的录音', 2),
        _bottomNavigationBarItem(Icons.person_outline, Icons.person, '我的', 3)
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      fixedColor: Colors.green,
      onTap: (index) {
        setState(() {
          _currentIndex = index; //修改当前页面索引
          // _pageController.jumpToPage(index);
          // _pageController.animateToPage(index,
          //   duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
}
