import 'dart:io';
import 'package:driverapp_project/globalvariabels.dart';
import 'package:driverapp_project/widgets/NotificationDialog.dart';
import 'package:driverapp_project/widgets/ProgressDialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class PushNotificationService {
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize(context) async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        fetchRideInfo(getRideID(message), context);
      },


      onLaunch: (Map<String, dynamic> message) async {
        fetchRideInfo(getRideID(message), context);
      },

      onResume: (Map<String, dynamic> message) async {
        fetchRideInfo(getRideID(message), context);
      },
    );
  }


  Future<String> getToken() async{
    String token = await fcm.getToken();
    print('token: $token');

    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child(
        'drivers/${currentFirebaseUser.uid}/token');
    tokenRef.set(token);

    fcm.subscribeToTopic('alldrivers');
    fcm.subscribeToTopic('allusers');
  }


  String getRideID(Map<String, dynamic> message){
    String rideID = '';
    if (Platform.isAndroid) {
      rideID = message['data']['ride_id'];
    }
    else {
      rideID = message['ride_id'];
      print('ride_id: $rideID');
    }
    return rideID;
  }

  void fetchRideInfo(String rideID, context){

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Fetching Details',),
    );

    Navigator.pop(context);


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => NotificationDialog(),
    );
    }
    }














