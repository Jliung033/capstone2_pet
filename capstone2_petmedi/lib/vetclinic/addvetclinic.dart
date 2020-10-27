
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:capstone2_petmedi/login.dart';

class AddClinic extends StatefulWidget {
  @override
  _AddClinicState createState() => new _AddClinicState();
}

//Temporary Data

class _AddClinicState extends State<AddClinic> {
  TextEditingController controllerCname = new TextEditingController();
  TextEditingController controllerTeleno = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerCity = new TextEditingController();

  String gettheaccid() {
    return '$getaccid';
  }

  getpettypeid() {
    return '1';
  }
String id;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Future<List> getData() async {

    final resp = await http.post(
        "http://10.0.2.2:8080/capstone2_petmedi/getidonly.php",
        body: {"account_id": gettheaccid()});

    Future.delayed(Duration(seconds: 3), () {
      var url = "http://10.0.2.2/capstone2_petmedi/addvetclinic.php";
      http.post(url, body: {
      "cname": controllerCname.text,
      "tele_no": controllerTeleno.text,
      "address": controllerAddress.text,
      "city": controllerCity.text,
      "veterinarian_id": id,
    });
    });

    var getdata = json.decode(resp.body);
    id = getdata[0]['veterinarian_id'];
    return getdata;
  }



  Widget _buildCname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Clinic Name', hintText: "Clinic Name"),
      controller: controllerCname,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Clinic Name is Required';
        }
        return null;
      },
    );
  }

  Widget _buildTeleno() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Telephone No.', hintText: "Telephone No."),
      controller: controllerTeleno,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Telephone No. is Required';
        }
        return null;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address', hintText: "Address"),
      controller: controllerAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City', hintText: "City"),
      controller: controllerCity,
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is Required';
        }
        return null;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD Clinic"),
      ),
      body: Form(
        key: _form,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: new Column(
                children: <Widget>[
                  _buildCname(),
                  _buildTeleno(),
                  _buildAddress(),
                  _buildCity(),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  
                      RaisedButton(
                        child: new Text("ADD PET"),
                        color: Colors.blueAccent,
                        onPressed: () {
                          if (_form.currentState.validate()) {
                              
                              getData();
                              Navigator.pop(context);
                        
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
