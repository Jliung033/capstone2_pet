import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:capstone2_petmedi/login.dart';
import 'package:capstone2_petmedi/Vet/vetreg.dart';
class SwiperScreen extends StatefulWidget {
  @override
  _SwiperScreenState createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  final List<String> titles = [
    "Requirements",
    "A e-copy of",
    "A Clear Photo",
    "A Clear Selfie",
    "Documents",
    "That's All!",
  ];
  final List<String> subtitles = [
    "For Veterinarian Registrations",
    "Doctor of Veterinary Medicine\n(DVM) degree",
    "of your valid PRC license",
    "with your any\n government valid ID \n like passport, driver license",
    "that can support your\n proof of profession \n like certificates, \nBIR registrations for clinics, \n etc",
    "Let's get started!"
  ];
  final List<Color> colors = [
    Colors.red.shade300,
    Colors.orange.shade300,
    Colors.purple.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.indigo.shade300,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _controller,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.blue,
                activeSize: 20.0,
              ),
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return IntroItem(
                title: titles[index],
                subtitle: subtitles[index],
                backgroundcolor: colors[index],
                imageUrl: "assets/swiperpics/${index + 1}.png",
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              child: Text("Go Back"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon:
                  Icon(_currentIndex == 5 ? Icons.check : Icons.arrow_forward),
              onPressed: () {
                if (_currentIndex != 5)
                  _controller.next();
                else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vetreg()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundcolor;
  final String imageUrl;

  const IntroItem(
      {Key key,
      @required this.title,
      this.subtitle,
      this.backgroundcolor,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundcolor ?? Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 20.0),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 35.0),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Material(
                      elevation: 5.0,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
