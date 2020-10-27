import 'package:capstone2_petmedi/Schedule/addsched.dart';
import 'package:capstone2_petmedi/Starting.dart';
import 'package:capstone2_petmedi/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Starting.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:capstone2_petmedi/main.dart';
import 'pincode.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: <Widget>[
        SplashScreen(
          backgroundColor: Colors.blueAccent,
          seconds: 5,
          image: Image.asset('assets/gifs/waving.gif'),
          photoSize: 120.0,
          navigateAfterSeconds: LoginPage(),
        ),
        Container(
          padding: EdgeInsets.only(left: 60.0, top: 20.0),
          child: Row(children: <Widget>[
            Text(
              "Pet",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 75.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Puppybellies',
                decoration: TextDecoration.underline,
                color: Colors.white,
                decorationThickness: 3.0,
              ),
            ),
            Text(
              "Medi",
              style: TextStyle(
                fontSize: 75.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Puppybellies',
                decoration: TextDecoration.underline,
                color: Colors.orange,
                decorationThickness: 3.0,
              ),
            ),
            
          ]),
        ),
      ]),
    );
  }
}
