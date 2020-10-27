// ADD PET PROFILE
import 'package:capstone2_petmedi/PetUser/pets/viewpets.dart';
import 'package:capstone2_petmedi/login.dart';
import 'package:capstone2_petmedi/PetUser/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class AddPet extends StatefulWidget {
  @override
  _AddPetState createState() => new _AddPetState();
}

//Temporary Data

class _AddPetState extends State<AddPet> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerBreed = new TextEditingController();
  TextEditingController controllerSex = new TextEditingController();
  TextEditingController controllerColor = new TextEditingController();
  TextEditingController controllerDbirth = new TextEditingController();
  TextEditingController controllerAllergies = new TextEditingController();
  TextEditingController controllerDiet = new TextEditingController();
  TextEditingController controllerPetimage = new TextEditingController();

  getpetuserid() {
    return '$petuserid';
  }

  getpettypeid() {
    return '1';
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void addPet() {
    var url = "http://10.0.2.2:8080/capstone2_petmedi/addpet.php"; //fill

    http.post(url, body: {
      "name": controllerName.text,
      "breed": controllerBreed.text,
      "sex": controllerSex.text,
      "color": controllerColor.text,
      "dbirth": controllerDbirth.text,
      "petimage": getpetimage(),
      "allergies": controllerAllergies.text,
      "diet": controllerDiet.text,
      "pettypeid": getpettypeid(),
      "petuserid": getpetuserid(),
    });
  }

  getpetimage() {
    return '$imagename';
  }

  String imagename;

  Widget _buildPname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pet Name', hintText: "Pet Name"),
      controller: controllerName,
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pet Name is Required';
        }
        return null;
      },
    );
  }

  Widget _buildBreed() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Breed', hintText: "Breed/Breeds"),
      controller: controllerBreed,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Breed is Required';
        }
        return null;
      },
    );
  }

  Widget _buildSex() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Sex', hintText: "Sex"),
      controller: controllerSex,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Sex is Required';
        }
        return null;
      },
    );
  }

  Widget _buildColor() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Color', hintText: "Color"),
      controller: controllerColor,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Color is Required';
        }
        return null;
      },
    );
  }

  Widget _buildDbirth() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Date of Birth', hintText: "Date of Birth"),
      controller: controllerDbirth,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date of Birth is Required';
        }
        return null;
      },
    );
  }

  Widget _buildAllergies() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Allergies', hintText: "Allergy/Allergies"),
      controller: controllerAllergies,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input none if no allergy';
        }
        return null;
      },
    );
  }

  Widget _buildDiet() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Diet', hintText: "Diet"),
      controller: controllerDiet,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input none if no diet';
        }
        return null;
      },
    );
  }

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
          return Center(
            child: const Text(
              'Show license here',
              textAlign: TextAlign.center,
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD PET"),
      ),
      body: Form(
        key: _form,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: new Column(
                children: <Widget>[
                  _buildPname(),
                  _buildBreed(),
                  _buildSex(),
                  _buildColor(),
                  _buildDbirth(),
                  _buildAllergies(),
                  _buildDiet(),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      showImage(),
                      RaisedButton(
                        child: new Text("ADD PET"),
                        color: Colors.blueAccent,
                        onPressed: () {
                          if (_form.currentState.validate()) {
                            setState(() {
                              startUpload();
                              addPet();
                              Navigator.pop(context);
                            });
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
