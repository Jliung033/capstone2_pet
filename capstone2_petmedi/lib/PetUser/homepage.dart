import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:capstone2_petmedi/login.dart';
import 'package:capstone2_petmedi/PetUser/pets/viewpets.dart';

//import 'main.dart';

class PetUserPage extends StatefulWidget {
  PetUserPage({this.username, this.password});

  final String password;
  final String username;

  @override
  _PetUserPageState createState() => _PetUserPageState();
}

class _PetUserPageState extends State<PetUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF8F8FA),
      backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.yellow[800]])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              ////// Second Layer ///////
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        height: 65,
                        width: 65,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/dog2.jpg',
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hello, $username",
                            style: TextStyle(
                                color: Colors.amber[800],
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          Text("Edit Profile",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  ]),
            ),
            ////////// CAROUSEL LAYER /////////

            Center(
                child: Expanded(
                    child: Container(height: 160, child: ImageCarousel()))),

            //////////ICON LAYER /////////

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5, color: Colors.amber[800]),
                  bottom: BorderSide(width: 5, color: Colors.amber[800]),
                ),
                color: Colors.blue[400],
              ),
              padding: EdgeInsets.fromLTRB(12, 20, 12, 40),
              //color: Colors.amber[600],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.pets,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (Mypets()),
        ),
      );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'My Pets',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.payment,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                    Text(
                      'Payments',
                      style: TextStyle(color: Colors.white),
                    ),
                  ])),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.local_hospital,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Veterinarians',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.monetization_on,
                              size: 32,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Text(
                          'Rewards',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.contact_mail,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'My Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.local_library,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Text(
                          'Pet Guide',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.today,
                              size: 33,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Appointments',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.help_outline,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                        Text(
                          'About Us',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /////// CARDS LAYER///////
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10, 5, 5),
              child: Text(
                'PETMEDI COMMUNITY',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            )),

            Container(
              margin: EdgeInsets.all(5.0),
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.asset(
                            'assets/dog3.jpg',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Heading1"),
                              subtitle: Text("SubHeading"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.asset('assets/dog4.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Heading1"),
                              subtitle: Text("SubHeading"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.asset('assets/dog3.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Heading1"),
                              subtitle: Text("SubHeading"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.asset('assets/dog3.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Heading1"),
                              subtitle: Text("SubHeading"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160.0,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.asset('assets/dog6.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("Heading1"),
                              subtitle: Text("SubHeading"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

////// IMAGE SLIDER ///////

class ImageCarousel extends StatelessWidget {
  final carousel = Carousel(
    boxFit: BoxFit.cover,
    dotBgColor: Colors.grey[800].withOpacity(0.0),
    images: [
      AssetImage('assets/dog1.jpg'),
      AssetImage('assets/dog2.jpg'),
      AssetImage('assets/dog3.jpg'),
      AssetImage('assets/dog4.jpg'),
    ],
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 2000),
  );

  final banner = new Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15.0),
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text('PETMEDI SERVICES', style: TextStyle(color: Colors.white)));

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
        child: Stack(
      children: <Widget>[
        carousel,
        banner,
      ],
    ));
  }
}

//////APP BAR ///////

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
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(50));
}
