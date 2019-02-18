import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Login();
  }
}

class _Login extends State<Login> {
  var bodexDecoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[600], width: 0.2)));

  var _passIconColors = Colors.grey;

  bool _isShowPass = true;

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 150.0,
              margin: EdgeInsets.only(top: 100.0),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/logo.png")),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[400], width: 0.1),
              ),
              width: 300.0,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: bodexDecoration,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                          fillColor: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "账户名",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    decoration: bodexDecoration,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isShowPass, //是否是密码
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: MaterialButton(
                            child: Icon(
                              Icons.remove_red_eye,
                              color: _passIconColors,
                            ),
                            onPressed: () {
                              setState(() {
                                _isShowPass = !_isShowPass;
                                if(!_isShowPass){
                                  _passIconColors = Colors.green;
                                }else{
                                  _passIconColors = Colors.grey;
                                }
                              });

                            },
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          fillColor: Colors.white,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "密   码",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 330.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "*请使用CRM账号登录",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if(_usernameController.text.toString().isEmpty){

                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.green),
                      child: Center(
                        child: Text(
                          "登录",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
