import 'dart:convert';

import 'package:flutter/material.dart';
import 'PetUser/homepage.dart';
import 'package:capstone2_petmedi/main.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/PetUser/petuserreg.dart';
import 'package:capstone2_petmedi/Vet/vetreg.dart';
import 'swiperscreen.dart';

void main() => runApp(new MyApp());

String username = '';
String password;
String id;
String getaccid = '';
String vetuserid;
String petuserid;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login PHP My Admin',
        home: new LoginPage(),
        routes: <String, WidgetBuilder>{
          //  '/VetUserPage': (BuildContext context) =>
          //      new VetUserPage(username: username),
          //  '/PetUserPage': (BuildContext context) =>
          //      new PetUserPage(username: username),
          //'/Petuserregister': (BuildContext context) => new Petuserregister(),
          '/LoginPage': (BuildContext context) => new LoginPage(),
        });
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {      
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  
  
  //get vet user
  Future<List> getvetuserid() async {
    final response = await http
        .post("http://10.0.2.2/capstone2_petmedi/getdatapetuser.php", body: {
      "accountid": id,
    });

    var getdata = json.decode(response.body);
    vetuserid = getdata[0]['vetuser_id'];

    return getdata;
  }

  Future<List> getpetuserid() async {
    final response = await http
        .post("http://10.0.2.2/capstone2_petmedi/getdatapetuser.php", body: {
      "accountid": id,
    });

    var getdata = json.decode(response.body);
    petuserid = getdata[0]['petuser_id'];

    return getdata;
  }

  String msg = '';
  // 1st step HTTP POST

  String getaccountid = '';
  Future<List> _login() async {
    final response = await http
        .post("http://10.0.2.2:8080/capstone2_petmedi/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        
        _builderrordialog();

      });
    } else {
      if (datauser[0]['usertype'] == '2') {
        id = datauser[0]['account_id'];
        getpetuserid();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PetUserPage()));
      } else if (datauser[0]['usertype'] == '1') {
        id = datauser[0]['account_id'];
        getvetuserid();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PetUserPage()));
      }

      setState(() {
        username = datauser[0]['username'];
        password = datauser[0]['password'];
      });
    }

    return datauser;
  }

  String vetuserid;

  String gettheaccid() {
    return '$getaccid';
  }

  Widget _buildUsername() {
    return TextFormField(
      //USERNAME --------------------
      controller: user,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Username is Required';
        }
        return null;
      },
      decoration: new InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
        labelText: 'Username',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
  
  Widget _buildPassword() {
    return TextFormField(
      controller: pass,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        return null;
      },
      decoration: new InputDecoration(
        prefixIcon: Icon(
          Icons.https,
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  
  Widget _buildLogin() {
    return RaisedButton(
        child: Text('Login'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xffffffff),
        textColor: Color(0xffEE7B23),
        splashColor: Colors.amber[600],
        onPressed: () {
          if (_form.currentState.validate()) {
            getaccid = id;
            _login();
          }
        });
  }

  _builderrordialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          child: Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.red,
                    ),
                  ),
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 25.0),
                Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Oopps!! There is\nsomething wrong.",
                        labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 180.0,
                      height: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/error.png'),
                        ),
                      ),
                    ),
                    CloseButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVetorPet(){
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you a?."),
              actions: <Widget>[FlatButton(onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Petuserreg(),
                  ),
                );
                    }, child: Text("Veterinarian?")),
                  FlatButton(onPressed: (){
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Vetreg(),
                  ),
                );
                  }, child: Text("Pet User?"))],
              
            ));
  }

  Widget _buildRegister() {
    return RaisedButton(
      child: Text('Register'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Color(0xffEE7B23),
      textColor: Color(0xffffffff),
      splashColor: Colors.white24,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "I'm registering for..",
                            labelStyle: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 10.0),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(12),
                        //   topRight: Radius.circular(12),
                        // ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 110.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/vet.png'),
                            ),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SwiperScreen(),
                                ),
                              );
                              debugPrint('ButtonClicked');
                            },
                            child: Text(
                              "Veterinarian",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            padding: const EdgeInsets.only(top: 140),
                          ),
                        ),
                        Container(
                          width: 110.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/po.png'),
                            ),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Petuserreg(),
                              //   ),
                              // );
                              debugPrint('ButtonClicked');
                            },
                            child: Text(
                              "Pet User",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            padding: const EdgeInsets.only(top: 140),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(150, 60, 150, 10),
                      child: CloseButton(
                        color: Colors.white,
                        // onPressed: () {},
                        onPressed: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Petuserreg(),
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildForgetPass() {
    return FlatButton(
      onPressed: () {
        // MaterialPageRoute(
        //   builder: (context) => Vetreg(),
        // );
      },
      child: Text(
        'Forgot Password',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(key: _form,
      child:
        Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color: Colors.amber[800],
                  ),
                  child: new Icon(
                    Icons.pets,
                    color: Colors.white,
                    size: 40.0,
                  ),
                )
              ],
            ),
            new Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildForgetPass(),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'PETMEDI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial'),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: _buildUsername(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildPassword(),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 10.0, top: 30.0),
                        child: 
                        _buildLogin()),
                  ),
                 Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 10.0, top: 30.0),
                        child: _buildRegister()),
                  ),
                  
                ]),
          ],
        ),
      ),)
    );
  }
}
