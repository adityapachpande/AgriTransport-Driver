
import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'dataprovider/address.dart';
import 'dataprovider/appdata.dart';
import 'package:http/http.dart' as http;


String mapKey = 'AIzaSyD5NuKqAzz2qlyqZq_sJ5ZXQeWAjgFl4Bk';

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);


User currentFirebaseUser;

DatabaseReference tripRequestRef;

StreamSubscription<Position> homeTabPositionStream;


class RequestHelper{

  static Future<dynamic> getRequest(String url) async{  //static for acesssing this method without accssing class

    http.Response response = await http.get(url);

    try{
      if(response.statusCode == 200){
        String data = response.body;
        var decodeData = jsonDecode(data);
        return decodeData;
      }
      else{
        return 'failed';
      }
    }
    catch(e){
      return 'failed';
    }

  }
}


class HelperMethods{

  static Future<String> findCordinateAddress(Position position, context)async{

    String placeAddress = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
      return placeAddress;
    }



    String url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/${position.latitude},${position.longitude}.json?access_token=pk.eyJ1IjoiYWRpdHlhLXBhY2hwYW5kZSIsImEiOiJja24wNTNib3kwazdrMnVvM2Joa3ZvcGVvIn0.adsHNz_zZTWB0XO5A5DnoA';



    var response = await RequestHelper.getRequest(url);

    if(response != 'failed'){

      placeAddress = response['results'][0]['formatted_address'];

      Address pickupAdress = new Address();
      pickupAdress.longitude = position.longitude;
      pickupAdress.latitude = position.latitude;
      pickupAdress.placeName = placeAddress;

      Provider.of<AppData>(context , listen: false).updatePickupAddress(pickupAdress);

    }

    return placeAddress;

  }
}


