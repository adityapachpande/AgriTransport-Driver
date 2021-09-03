

import 'package:flutter/cupertino.dart';

import 'address.dart';

class AppData extends ChangeNotifier{

  Address pickupAddress;

  get pickupLocation => null;
  // method to update pickup adrress while strartup of app

  void updatePickupAddress(Address pickup){
    pickupAddress = pickup;
    notifyListeners(); //broadcast the changes made

  }


}