import 'dart:convert';
import 'dart:async';
import 'package:capstone2_petmedi/PetUser/petuserreg2.dart';
import 'package:capstone2_petmedi/Starting.dart';
import 'package:capstone2_petmedi/Vet/uploadpic.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server
import 'package:capstone2_petmedi/PetUser/pincode.dart';

// WALA PA import 'package:capstone2_petmedi/Vet/docusubmit.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class Petuserreg extends StatefulWidget {
  @override
  _Petuserreg createState() => new _Petuserreg();
}

//getdata to success page
String getusernamepet = '';
String getpasswordpet = '';
String getfirstnamepet = '';
String getlastnamepet = '';
String getemailpet = '';

String name = '';

class _Petuserreg extends State<Petuserreg> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  TextEditingController controllerFirstname = new TextEditingController();
  TextEditingController controllerLastname = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerVcode = new TextEditingController();
  TextEditingController controllerRetype = new TextEditingController();

  String _retype;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  resendemail() async {
    String email = 'petmedi2021@gmail.com';
    String password = 'capstone2_petmedi';

    final smtpServer = gmail(email, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(email)
      ..recipients.add('${controllerEmail.text}') //recipent email
      ..subject = 'New Verification Code' //subject of the email
      ..text =
          'This is your new verification code ${controllerVcode.text}'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  resend() async {
    Navigator.pop(context);
    controllerVcode.text = randomNumeric(6);
    resendemail();
    _builddialog();
  }

  sendemail() async {
    String email = 'petmedi2021@gmail.com';
    String password = 'capstone2_petmedi';

    final smtpServer = gmail(email, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(email)
      ..recipients.add('${controllerEmail.text}') //recipent email
      ..subject = 'Verification Code' //subject of the email
      ..text =
          'Please input this code ${controllerVcode.text}'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  sendandadd() async {
    controllerVcode.text = randomNumeric(6);
    await sendemail();
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

  checkcode() {
    if (controllerVcode.text == controllerRetype.text) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (PinCode()),
        ),
      );
    } else if (controllerRetype.text != controllerVcode.text) {
      return 'Verification Code does not match';
    }
  }

  Widget _builddialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  "Please input the code sent to your email${controllerVcode.text}"),
              content: TextFormField(
                controller: controllerRetype,
                decoration: InputDecoration(
                    labelText: 'Verification Code',
                    hintText: "Verification Code"),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Verification Code is Required';
                  } else if (value != controllerVcode.text) {
                    return 'Verification Code does not match';
                  } else {
                    return null;
                  }
                },
              ),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5.0,
                    child: Text("Submit"),
                    onPressed: () {
                      if (controllerRetype.text != controllerVcode.text) {
                        return 'Verification Code does not match';
                      } else if (controllerVcode.text ==
                          controllerRetype.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (PinCode()),
                          ),
                        );
                      }
                      checkcode();
                    }),
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Resend code"),
                  onPressed: () {
                    resend();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          children: [
            new Text("PetUser Register"),
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
                              if (_form.currentState.validate()) {
                                getusernamepet = controllerUser.text;
                                getpasswordpet = controllerPass.text;
                                getfirstnamepet = controllerFirstname.text;
                                getlastnamepet = controllerLastname.text;
                                getemailpet = controllerEmail.text;
                                sendandadd();
                                _builddialog();
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
