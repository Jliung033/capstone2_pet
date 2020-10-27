import 'package:capstone2_petmedi/PetUser/petuserreg.dart';
import 'package:capstone2_petmedi/Starting.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/Vet/vetreg.dart';
import 'package:capstone2_petmedi/PetUser/petuserreg2.dart';

// UPLOAD PICTURE IMPORT
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class PinCode extends StatefulWidget {
  final String title = "Upload Image Demo ";

  @override
  PinCodeState createState() => PinCodeState();
}

String id;
String getpinpet='';

class PinCodeState extends State<PinCode> {
  TextEditingController controllerPin = new TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  

  Widget _buildPincode() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'PIN', hintText: "PIN"),
      controller: controllerPin,
      maxLength: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return 'PIN is Required';
        }
        return null;
      },
    );
  }

    Widget _buildAreyousure(){
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure?."),
              actions: <Widget>[FlatButton(onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Petuserreg2(),
                  ),
                );
                    }, child: Text("Yes?")),
                  FlatButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("No"))],
              
            ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Upload License "),

            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: _form,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                      child: new Column(
                        children: <Widget>[
                          _buildPincode(),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 380,
                              child: new RaisedButton(
                                child: new Text(
                                  "SUBMIT PIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                                onPressed: () {
                                  
                                  if (_form.currentState.validate()) {
                                    
                                  getpinpet = controllerPin.text;
                                    _buildAreyousure();
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
        ));
  }
}
