import 'package:driverapp_project/screens/launchmap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewTripPage extends StatefulWidget {
  @override
  _NewTripPageState createState() => _NewTripPageState();
}

class _NewTripPageState extends State<NewTripPage> {

  String dataToChange = "     ";

  String changedata(){
    setState(() {
      dataToChange = "Trip is Ended";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('New Trip',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Brand-Bold',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      body: SafeArea(
        child: ListView(
        children: <Widget>[

           Container(
            child: Text( "You accept the trip request Destination Bhusawal from Jalgaon place. Start Timing: 11PM. You can call the Farmer for more info",
              style: TextStyle(fontSize: 15,
                  fontFamily: 'Brand-Bold',color: Colors.black),),
          ),


          RaisedButton(
            onPressed: _makingPhoneCall,
            child: Text('Call'),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15),
            ),
          ),

          RaisedButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaunchMap(),)
              );
              },
            child: Text('Direction'),
            color: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15),
            ),
          ),

          RaisedButton(
            onPressed: changedata,
            child: Text('Trip End'),
            color: Colors.blueGrey,
            splashColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "$dataToChange",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
}


_makingPhoneCall() async {
  const url = 'tel:9123456789';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}