import 'package:capstone2_petmedi/PetUser/petuserreg.dart';
import 'package:capstone2_petmedi/Vet/vetreg.dart';
import 'package:capstone2_petmedi/login.dart';
import 'package:flutter/material.dart';




class Starting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "I'm A..",
            style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          IconButton(
              icon: Image.asset('assets/images/vet.png'),
              padding: EdgeInsets.only(top: 30.0),
              iconSize: 90,
              //Navigating Vet Icon
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(title: Text("Do you have the following Document:"),
                    content: Text("Proof of License"),
                    actions: <Widget>[FlatButton(onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Vetreg(),
                  ),
                );
                    }, child: Text("Yes")),
                  FlatButton(onPressed: (){
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Starting(),
                  ),
                );
                  }, child: Text("No"))],
                    );
                  });
              }),
          Container(
            child: Text(
              "Veterinarian",
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          IconButton(
            icon: Image.asset('assets/images/pett.png'),
            padding: EdgeInsets.only(top: 30.0),
            iconSize: 90,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Petuserreg(),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "Pet Owner",
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5.0,
              bottom: 10.0,
            ),
            child: Text(
              "Already have an account? ",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Comfortaa',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15.0),
              RaisedButton(
                child: Text("Click here to login"),
                padding: EdgeInsets.all(20.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
