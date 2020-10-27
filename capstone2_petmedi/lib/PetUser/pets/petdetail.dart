import 'package:capstone2_petmedi/PetUser/pets/editpet.dart';
import 'package:capstone2_petmedi/PetUser/pets/viewpets.dart';
import 'package:flutter/material.dart';
import 'package:capstone2_petmedi/main.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/PetUser/pets/petdetail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:capstone2_petmedi/PetUser/pets/addpet.dart';

class PetDetail extends StatefulWidget {
  List list;
  int index;
  PetDetail({this.index, this.list});
  @override
  _PetDetailState createState() => new _PetDetailState();
}

String getidpet;

class _PetDetailState extends State<PetDetail> {
  void deletePet() {
    ///NO PHP FILE YET
    var url = "http://capstone2_petmedi/pets/deletepet.php";
    http.post(url, body: {'pet_id': widget.list[widget.index]['pet_id']});
  }

  // GET THE PET ID
  Future<List> getPetData() async {
    final response = await http
        .post("http://10.0.2.2/capstone2_petmedi/getidpet.php", body: {
      "petid": widget.list[widget.index]['pet_id'],
    });

    var datauser = json.decode(response.body);
    getidpet = datauser[0]['pet_id'];
    return datauser;
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to delete '${widget.list[widget.index]['name']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK DELETE!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deletePet();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => Mypets(), //fill navigatiom
            ));
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: new AppBar(
          backgroundColor: Colors.amber[600],
          title: Row(
            children: [
              Icon(Icons.pets),
              SizedBox(
                width: 8,
              ),
              new Text("Pet Profile"),
              //   Text(           widget.list[widget.index]['pet_id'],          style: new TextStyle(fontSize: 20.0),         ),
            ],
          )),
      body: new Container(
        height: 460.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          // CARD COLOR
          color: Colors.white,
          child: new Center(
            child: new Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                SizedBox(
                  height: 85,
                  width: 85,
                  child: ClipOval(
                    child: new Image(
                      image: NetworkImage(
                          "http://10.0.2.2/capstone2_petmedi/images/${widget.list[widget.index]['petimage']}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.list[widget.index]['name'],
                  style:
                      new TextStyle(fontSize: 20.0, color: Colors.amber[800]),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            new Text(
                              "BREED :",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['breed']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            new Text(
                              "BORN :",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['dbirth']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            new Text(
                              "COLOR :",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['color']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            new Text(
                              "SEX :",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['sex']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            new Text(
                              "ALLERGIES :",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['allergies']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            new Text(
                              "DIET:",
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800]),
                            ),
                            Text(
                              ' ${widget.list[widget.index]['diet']}',
                              style: new TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        "EDIT PET",
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditPet(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    new FlatButton(
                      child: new Text(
                        "DELETE",
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
