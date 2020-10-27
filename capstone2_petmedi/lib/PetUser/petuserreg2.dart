import 'package:capstone2_petmedi/PetUser/petuserreg.dart';
import 'package:capstone2_petmedi/Starting.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/Vet/vetreg.dart';
import 'package:capstone2_petmedi/PetUser/pincode.dart';

// UPLOAD PICTURE IMPORT
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class Petuserreg2 extends StatefulWidget {
  final String title = "Upload Image Demo ";

  @override
  Petuserreg2State createState() => Petuserreg2State();
}

String id;

gettheaddress() {
  return 'none';
}

getthecontactno() {
  return 'none';
}

getimage() {
  return 'none';
}

getthepoints() {
  return '0';
}

class Petuserreg2State extends State<Petuserreg2> {
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerContactNo = new TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Future<List> getData() async {

    final response = await http
        .post("http://10.0.2.2:8080/capstone2_petmedi/addacc.php", body: {
      "username": gettheuserpet(),
      "password": getthepasspet(),
      "firstname": getthefirstnamepet(),
      "lastname": getthelastnamepet(),
      "email": gettheemailpet(),
      "usertype": getusertype(),
      "status": getstatus(),
      "pin":getthepinpet(),
    }); 
    final resp = await http.post(
        "http://10.0.2.2:8080/capstone2_petmedi/getdata2pet.php",
        body: {"username": gettheuserpet(), "password": getthepasspet()});

    Future.delayed(Duration(seconds: 3), () {
      var url = "http://10.0.2.2:8080/capstone2_petmedi/addpetuser.php";
      http.post(url, body: {
        "address": controllerAddress.text,
        "contactno": controllerContactNo.text,
        "accountid": id,
        "points": getthepoints(),
      });
    });

    var getdata = json.decode(resp.body);
    id = getdata[0]['account_id'];
    return getdata;
  }
  

// Created Variable
  String imagename = '';
  String id;

  String gettheuserpet() {
    return '$getusernamepet';
  }

  String getthepasspet() {
    return '$getpasswordpet';
  }
  String getthefirstnamepet() {
    return '$getfirstnamepet';
  }
  String getthelastnamepet(){
    return '$getlastnamepet';
  }

  String gettheemailpet(){
    return '$getemailpet';
  }
    String getthepinpet(){
    return '$getpinpet';
  }
  String getstatus() {
  return 'activated';
}

String getusertype() {
  return '2';
  //pet
}

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address', hintText: "Address"),
      controller: controllerAddress,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
    );
  }

  Widget _buildContactNo() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Contact No.', hintText: "Contact No."),
      controller: controllerContactNo,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ContactNo is Required';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Personal Information "),
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
                          _buildAddress(),
                          _buildContactNo(),
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
                                  "Complete my Registration",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                                onPressed: () {
                                  if (_form.currentState.validate()) {
                                    print(' refresh state 2');
                                    getData();
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => (Starting()),
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
        ));
  }
}
