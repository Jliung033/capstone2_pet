import 'package:capstone2_petmedi/PetUser/pets/addpet.dart';
import 'package:capstone2_petmedi/PetUser/pets/petdetail.dart';
import 'package:capstone2_petmedi/PetUser/homepage.dart';
import 'package:capstone2_petmedi/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mypets extends StatefulWidget {
  @override
  _MypetsState createState() => _MypetsState();
}

String getdata;

getpetuserid() {
  return '$petuserid';
}

class _MypetsState extends State<Mypets> {
  Future<List> getPetData() async {
    final response = await http
        .post("http://10.0.2.2:8080/capstone2_petmedi/getpetdata.php", body: {
      "petuserid": getpetuserid(),
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF8F8FA),
      backgroundColor: Colors.blue[50],
      appBar: _getCustomAppBar(),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          // BuildPetPage
          builder: (BuildContext context) => new AddPet(),
        )),
      ),
      body: new FutureBuilder<List>(
        future: getPetData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new PetList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class PetList extends StatefulWidget {
  final List list;
  PetList({this.list});

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          height: 120,
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new PetDetail(
                      list: widget.list,
                      index: i,
                    ))),
            child: new Card(
              child: Column(
                children: [
                  new ListTile(
                    //ICON
                    leading: SizedBox(
                      height: 65,
                      width: 65,
                      child: ClipOval(
                        child: new Image(
                          image: NetworkImage(
                              "http://10.0.2.2:8080/capstone2_petmedi/images/${widget.list[i]['petimage']}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text("Name: ${widget.list[i]['name']}"),
                    subtitle: Row(
                      children: [
                        new Text("Breed : ${widget.list[i]['breed']}"),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

_getCustomAppBar() {
  return PreferredSize(
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.amber[600],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {}),
            Container(
              child: FlatButton.icon(
                icon: Icon(
                  Icons.pets,
                  color: Colors.white,
                ),
                label: Text(
                  'PETMEDI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState() {
                    print('refresh');
                  }
                }),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(50));
}
