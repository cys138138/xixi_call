import 'package:call/OsApplication.dart';
import 'package:call/events/LoginEvent.dart';
import 'package:call/pages/Login.dart';
import 'package:call/utils/SpUtils.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Mine();
  }
}

class _Mine extends State<Mine> {
  String avatarUrl;
  String nickname="";

  _Mine() {
    _initEvent();
    _getUserInfo();
  }

  void _initEvent() {
    OsApplication.eventBus.on<LoginEvent>().listen((event) {
      if(event.token == null){
        setState(() {
          nickname = "还没登录呢";
        });
      }else{
        _getUserInfo();
      }
    });
  }

  _login() async {
    final result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new Login();
    }));
  }

  _getUserInfo() async {
    SpUtils.getUserInfo().then((userInfoBean) {
      if (userInfoBean.token != null) {
        setState(() {
          avatarUrl = userInfoBean.avatar;
          nickname = userInfoBean.username;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var avatar = CircleAvatar(
        backgroundImage: new AssetImage('images/logo.png'),
        radius: 50
    );

    if (avatarUrl != null) {
      avatar = new CircleAvatar(
          backgroundImage: new NetworkImage(avatarUrl),
          radius: 50);
    }
    // TODO: implement build
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: ClipPath(
                  clipper: BottomClipper(),
                  child: new Container(
                    height: 230,
                    padding: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: new GestureDetector(
                      child: new Column(
                        children: <Widget>[
                          avatar,
                          new Container(
                            child: Text(
                              nickname,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16, height: 1.2),
                            ),
                            margin: EdgeInsets.only(top: 8),
                          )
                        ],
                      ),
                      onTap: () {
                      },
                    ),
                  )
              )
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              _buildItem("退出登录", (){
                _showDialog();
              }),
              new Divider(indent: 5, height: 0, color: Colors.grey[200]),
            ],
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildItem(String title, Function click) {

    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: new Container(
        child: new Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 8),
      ),
      onTap: click,
    );
  }

  _showDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
          title: new Text('提示'),
          content: new Text('是否要退出登录'),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text('取消')),
            new FlatButton(
                onPressed: () {
                  SpUtils.cleanUserInfo();
                  OsApplication.eventBus.fire(new LoginEvent(""));
                  Navigator.pop(context);
                },
                child: new Text('是的'))
          ],
        ),
        context: context);
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    var firstControlPoint = Offset(size.width / 5, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 5), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 6);

    int doble = 80;
    for (var i = 1; i <= (doble / 2); i++) {
      path.lineTo(size.width / doble * ((4 * (i - 1)) + 1), 6);
      path.quadraticBezierTo(size.width / doble * (2 * (2 * i - 1)), 0,
          size.width / doble * (4 * i - 1), 6);
      path.lineTo(size.width / doble * (4 * i), 6);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
