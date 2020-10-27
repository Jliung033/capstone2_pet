import 'dart:convert';
import 'dart:async';
import 'package:capstone2_petmedi/Starting.dart';
import 'package:capstone2_petmedi/Vet/uploadpic.dart';
import 'package:flutter/material.dart';

// WALA PA import 'package:capstone2_petmedi/Vet/docusubmit.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Vetreg extends StatefulWidget {
  @override
  _Vetreg createState() => new _Vetreg();
}

//getdata to success page
String getusername = '';
String getpassword = '';

String getstatus() {
  return 'unverified';
}

String getusertype() {
  return '1';
  //vet
}

String name = '';

class _Vetreg extends State<Vetreg> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  TextEditingController controllerFirstname = new TextEditingController();
  TextEditingController controllerLastname = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();

  String _retype;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void regVetuser() async {
    final response =
        await http.post("http://10.0.2.2:8080/capstone2_petmedi/addacc.php", body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
      "firstname": controllerFirstname.text,
      "lastname": controllerLastname.text,
      "email": controllerEmail.text,
      "usertype": getusertype(),
      "status": getstatus(),
    });

    var getdata = json.decode(response.body);
    return getdata;
  }

  Widget _buildUsername() {
    Container(
      child: TextFormField(
        decoration:
            InputDecoration(labelText: 'Username', hintText: "Username"),
        controller: controllerUser,
        maxLength: 15,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Username is Required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFirstname() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Firstname', hintText: "Firstname"),
      controller: controllerFirstname,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Firstname is Required';
        }
        return null;
      },
    );
  }

  Widget _buildLastname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Lastname', hintText: "Lastname"),
      controller: controllerLastname,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Lastname is Required';
        }
        return null;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email', hintText: "Email"),
      controller: controllerEmail,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid Email Address';
        }

        return null;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password', hintText: "Password"),
      controller: controllerPass,
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
    );
  }

  Widget _buildRetypepass() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Retype Password', hintText: "Password"),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value.isEmpty) return 'Retype Password is required';
        if (value != controllerPass.text) return 'Password does not match';
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: [
            new Text("Vet Reg Sample"),

            /// SET STATE
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    print('$name hello world');
                  });
                })
          ],
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Username', hintText: "Username"),
                          controller: controllerUser,
                          maxLength: 15,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Username is Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      _buildFirstname(),
                      _buildLastname(),
                      _buildEmail(),
                      _buildPassword(),
                      _buildRetypepass(),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 380,
                          child: new RaisedButton(
                            child: new Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blueAccent,
                            onPressed: () {
                              //controller

                              getusername = controllerUser.text;
                              getpassword = controllerPass.text;

                              if (_form.currentState.validate()) {
                                print(' refresh state 2');

                                regVetuser();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => (Uploaddocu()),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
