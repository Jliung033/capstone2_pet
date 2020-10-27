import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_petmedi/Starting.dart';
import 'package:intl/intl.dart';
import 'package:capstone2_petmedi/login.dart';



  getvetuserid() {
    return '$vetuserid';
  }
  getvetclinicid() {
    return 'None';
  }

class AddSched extends StatefulWidget {
  @override
  _AddSchedState createState() => new _AddSchedState();
}

class _AddSchedState extends State<AddSched> {
  TextEditingController controllerSched = new TextEditingController();
  TextEditingController controllerStime = new TextEditingController();
  TextEditingController controllerEtime = new TextEditingController();

  void addsched() {
    var url = "http://10.0.2.2:8080/capstone2_petmedi/addsched.php"; //fill

    http.post(url, body: {
      "day":controllerSched.text, //date yung type sa database
      "starttime": controllerStime.text, //varchar
      "timeend": controllerEtime.text,// varchar
      "veterinarianid": getvetuserid(),
      "vetclinic_id": getvetclinicid(),
    });
  }
  Widget _buildDaysched(){
  return TextFormField(  
           controller: controllerSched,
           decoration: InputDecoration(
           labelText: "Day of Schedule",
          
           hintText: "Schedule",), 
             onTap: () async{
           DateTime now = DateTime.now();
           DateFormat formatter = DateFormat('yyyy-MM-dd');
           FocusScope.of(context).requestFocus(new FocusNode());

           now = await showDatePicker(
                context: context, 
                initialDate:DateTime.now(),
                
                firstDate:DateTime(2000),
                lastDate: DateTime(2050));  
                
          controllerSched.text = formatter.format(now).toString();
          },);
  }
   Widget _buildStime(){
    return TextFormField(
    controller: controllerStime,  // add this line.
    decoration: InputDecoration(
    labelText: 'Start Time*',
  ),
  onTap: () async {
    TimeOfDay stime = TimeOfDay.now();
    FocusScope.of(context).requestFocus(new FocusNode());

    TimeOfDay picker =
        await showTimePicker(context: context, initialTime: stime,);
        
    if (picker != null && picker != stime) { // add this line.
      setState(() {
        stime = picker;
        controllerStime.text = picker.format(context);
      });
    }
  },
);
  }

    Widget _buildEtime(){
    return TextFormField(
    controller: controllerEtime,  // add this line.
    decoration: InputDecoration(
    labelText: 'End Time*',
  ),
  onTap: () async {
    TimeOfDay time = TimeOfDay.now();
    FocusScope.of(context).requestFocus(new FocusNode());

    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: time,);
        
    if (picked != null && picked != time) { // add this line.
      setState(() {
        time = picked;
        controllerEtime.text = picked.format(context);
      });
    }
  },
);
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD Schedule"),
      ),
      body: Form(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            new Column(
              children: <Widget>[
                _buildDaysched(),
                _buildStime(),
                _buildEtime(),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("ADD Sched"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    
                       addsched();
                       Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => AddSched(), //change null
                ),
              );
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
