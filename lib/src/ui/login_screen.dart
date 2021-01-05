import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/login_bloc.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userControler = new TextEditingController();
  TextEditingController _passControler = new TextEditingController();

  // var _userNameErr = "Please enter user name";
  // var _passWordErr = "Please enter password";
  // var _userNameInvalid = false;
  // var _passWordInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.all(15),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black38),
                child: FlutterLogo()),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                "Hello \nWelcome back",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: StreamBuilder(
                  stream: bloc.userStream,
                  builder: (context, snapshot) => TextField(
                        controller: _userControler,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        onChanged: (String value) {
                          bloc.clearErr();
                        },
                        decoration: InputDecoration(
                            labelText: "USERNAME",
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                                TextStyle(color: Colors.black38, fontSize: 13)),
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshot) => TextField(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            controller: _passControler,
                            obscureText: !_showPass,
                            maxLength: 6,
                            onChanged: (String value) {
                              bloc.clearErr();
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(right: 100),
                                labelText: "PASSWORD",
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                labelStyle: TextStyle(
                                    color: Colors.black38, fontSize: 13)),
                          )),
                  GestureDetector(
                    onTap: onToggleShowPass,
                    child: Text(
                      _showPass ? "HIDE" : "SHOW",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  onPressed: onSignIn,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          'NEW USER?',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void onSignIn() {
  //   setState(() {
  //     if (_userControler.text.length <= 0) {
  //       _userNameInvalid = true;
  //     } else {
  //       _userNameInvalid = false;
  //     }
  //     if (_passControler.text.length <= 0) {
  //       _passWordErr = "Please enter password";
  //       _passWordInvalid = true;
  //     } else if (_passControler.text.length < 6) {
  //       _passWordErr = "Password includes 6 characters";
  //       _passWordInvalid = true;
  //     } else {
  //       _passWordInvalid = false;
  //     }
  //     if (!_userNameInvalid && !_passWordInvalid) {
  //       // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     }
  //   });
  // }

  void onSignIn() {
    if (bloc.isValidInfo(_userControler.text, _passControler.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }

  // void clearErr() {
  //   setState(() {
  //     _userNameInvalid = false;
  //     _passWordInvalid = false;
  //   });
  // }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
