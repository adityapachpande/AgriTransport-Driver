import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'package:driverapp_project/brand_colors.dart';
import 'package:driverapp_project/helpers/pushnotificationservice.dart';
import 'package:driverapp_project/widgets/AvailabilityButton.dart';
import 'package:driverapp_project/widgets/ConfirmSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globalvariabels.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  Position currentPosition;

  void getCurrentPosition() async {
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
     currentPosition = position;
     LatLng pos = LatLng(position.latitude, position.longitude);
     mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  DatabaseReference tripRequestRef;

  String availabilityTitle = 'GO ONLINE';
  Color availabilityColor = BrandColors.colorOrange;

  bool isAvailable = false;



    setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
    CameraPosition cp = new CameraPosition(target: pos, zoom:14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));


    String address = await HelperMethods.findCordinateAddress(position , context);
    print(address);

  }


  void getCurrentDriverInfo () async {
      currentFirebaseUser = await FirebaseAuth.instance.currentUser;
      PushNotificationService pushNotificationService = PushNotificationService();

      pushNotificationService.initialize(context);
      pushNotificationService.getToken();
    }

    @override
    void initState() {
      super.initState();
      getCurrentDriverInfo();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: googlePlex,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              mapController = controller;

              getCurrentPosition();
            },
          ),

           Container(
             height: 135,
             width: double.infinity,
             color: BrandColors.colorPrimary,
           ) ,

            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AvailabilityButton(
                title: availabilityTitle,
                color: availabilityColor,
                onPressed: (){


                  showModalBottomSheet(
                    isDismissible: false,
                      context: context,
                      builder: (BuildContext context) => ConfirmSheet(
                        title: (!isAvailable) ? 'GO ONLINE' : 'GO OFFLINE',
                        subtitle: (!isAvailable) ? 'You are about to become available to receive trip requests': 'you will stop receiving new trip requests',

                        onPressed: (){

                          if(!isAvailable){
                            GoOnline();
                            Navigator.pop(context);

                            setState(() {
                              availabilityColor = BrandColors.colorGreen;
                              availabilityTitle = 'GO OFFLINE';
                              isAvailable = true;
                            });

                          }
                          else{
                            GoOffline();
                            Navigator.pop(context);
                            setState(() {
                              availabilityColor = BrandColors.colorOrange;
                              availabilityTitle = 'GO ONLINE';
                              isAvailable = false;
                            });
                          }
                          },
                      ),
                  );
                  },
              ),
              ],
            ),
            )
        ],
        )
    );
    }



    void GoOnline(){
    Geofire.initialize('driversAvailable');
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);

    tripRequestRef = FirebaseDatabase.instance.reference().child('drivers/$currentFirebaseUser.uid}/newtrip');
    tripRequestRef.set('waiting');

    tripRequestRef.onValue.listen((event) {
    });
  }


  void GoOffline (){
      Geofire.removeLocation(currentFirebaseUser.uid);
      tripRequestRef.onDisconnect();
      tripRequestRef.remove();
      tripRequestRef = null;
    }


}








