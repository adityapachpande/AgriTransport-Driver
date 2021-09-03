import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchMap extends StatefulWidget {
  @override
  _LaunchMapState createState() => _LaunchMapState();
}

class _LaunchMapState extends State<LaunchMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: GestureDetector(
        onTap: () {
          launchMap();
        },
        child: Container(
          // alignment:  Alignment.centerRight,
          height: 50,
          width: 170,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1.0, color: Colors.white54),
          ),
          child: Icon(Icons.navigation, size: 35, color: Colors.redAccent,
          ),
        ),
      ),
    );
  }


  launchMap() async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$_currentPosition.latitude,$_currentPosition.longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    else {
      throw "Couldn't launch URL";
    }
  }


}

class _currentPosition {

  launchMap() async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$_currentPosition.latitude,$_currentPosition.longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    else {
      throw "Couldn't launch URL";
    }
  }
}
