import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/Vet/vetreg.dart';

// UPLOAD PICTURE IMPORT
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class Uploaddocu extends StatefulWidget {
  final String title = "Upload Image Demo ";

  @override
  UploaddocuState createState() => UploaddocuState();
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

class UploaddocuState extends State<Uploaddocu> {
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerContactNo = new TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Future<List> getData() async {
    final response = await http.post(
        "http://10.0.2.2:8080/capstone2_petmedi/getdata2.php",
        body: {"username": gettheuser(), "password": getthepass()});

    Future.delayed(Duration(seconds: 3), () {
      var url = "http://10.0.2.2:8080/capstone2_petmedi/addvet.php";
      http.post(url, body: {
        "address": controllerAddress.text,
        "contactno": controllerContactNo.text,
        "vetimage": getimage(),
        "accountid": id,
      });
    });

    var getdata = json.decode(response.body);
    id = getdata[0]['account_id'];
    return getdata;
  }

// Created Variable
  String imagename = '';
  String id;

  String gettheuser() {
    return '$getusername';
  }

  String getthepass() {
    return '$getpassword';
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

  String getimage() {
    return '$imagename';
  }

  //String small = info;
  //String info = controllerUser;

  static final String uploadEndPoint =
      'http://10.0.2.2:8080/capstone2_petmedi/images/upload_image.php';

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      print('$fileName 1st print image');
      imagename = fileName;
    }).catchError((error) {
      setStatus(error);
    });
  }

  // IMAGE
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());

          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else
          return const Text(
            'Show license here',
            textAlign: TextAlign.center,
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Upload License "),
              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      print('$getusername and $getpassword set state / $id id');
                    });
                  })
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                child: Text(
                                  'LICENSE',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: OutlineButton(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1.5,
                                    ),
                                    onPressed: chooseImage,
                                    child: Text('Choose Image'),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: OutlineButton(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1.5,
                                    ),
                                    onPressed: startUpload,
                                    child: Text('Save'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Container(
                                  height: 220, width: 170, child: showImage()),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
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
                                    print(' refresh state 2');
                                    startUpload();
                                    //    addImage();
                                    getData();
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
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
        ));
  }
}
