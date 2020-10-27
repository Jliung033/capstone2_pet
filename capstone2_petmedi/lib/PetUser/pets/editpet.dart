import 'package:flutter/material.dart';
import 'package:capstone2_petmedi/PetUser/pets/viewpets.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/main.dart';

import 'package:capstone2_petmedi/PetUser/pets/addpet.dart';

class EditPet extends StatefulWidget {
  final List list;
  final int index;

  EditPet({this.list, this.index});

  @override
  _EditPetState createState() => new _EditPetState();
}

class _EditPetState extends State<EditPet> {
  TextEditingController controllerName;
  TextEditingController controllerBreed;
  TextEditingController controllerSex;
  TextEditingController controllerColor;
  TextEditingController controllerDbirth;
  TextEditingController controllerAllergies;
  TextEditingController controllerDiet;
  //TextEditingController controllerPetimage;

  void editPet() {
    var url = "http://fill/fill/fill.php";
    http.post(url, body: {
      "pet_id": widget.list[widget.index]['pet_id'],
      "allergies": controllerAllergies.text,
      "diet": controllerDiet.text,
    });
  }

  @override
  void initState() {
    controllerName =
        new TextEditingController(text: widget.list[widget.index]['name']);

    controllerAllergies =
        new TextEditingController(text: widget.list[widget.index]['allergies']);
    controllerDiet =
        new TextEditingController(text: widget.list[widget.index]['diet']);
    //controllerPetimage =
    //    new TextEditingController(text: widget.list[widget.index]['petimage']);
    super.initState();
  }

  Widget _editname() {
    return TextFormField(
        decoration:
            InputDecoration(labelText: 'Pet Name', hintText: "Pet Name"),
        controller: controllerName);
  }

  Widget _editAllergies() {
    return TextFormField(
        decoration:
            InputDecoration(labelText: 'Allergies', hintText: "Allergies"),
        controller: controllerAllergies);
  }

  Widget _editDiet() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Diet', hintText: "Diet"),
        controller: controllerDiet);
  }

  //temporary only change later
  // Widget _editPimage() {    return TextFormField(       decoration:            InputDecoration(labelText: 'Pet Name', hintText: "Pet Name"),        controller: controllerPetimage);  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDIT PET"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                _editname(),
                _editAllergies(),
                _editDiet(),
                //_editPimage(),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("EDIT PET"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editPet();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Mypets())); //change route if done
                  },
                ),
                new RaisedButton(
                  child: new Text("refresh"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      print('');
                    }); //change route if done
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
