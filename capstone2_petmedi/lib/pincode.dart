import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:capstone2_petmedi/PetUser/homepage.dart';




class PinCode extends StatelessWidget {

  final String requiredNumber = '12345';
  //change to user's pin code
  //get user's pin code
  // lagay nyo sa pubspecyaml pin_code_fields:  <--

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code.',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter pin number',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                PinCodeTextField(
                  appContext: context,
                  length: 5,
                  onChanged: (value) {
                    print(value);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,                    
                    inactiveColor: Colors.purple,
                    activeColor: Colors.orange,
                    selectedColor: Colors.brown,
                    
                  ),
                  onCompleted: (value){
                    if(value == requiredNumber){
                      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetUserPage(),
                ),
              );
                    } else {
                      print('invalid pin');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
