import 'package:driverapp_project/brand_colors.dart';
import 'package:driverapp_project/widgets/TaxiButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../globalvariabels.dart';
import 'mainpage.dart';

class VehicleInfoPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }


  static const String id = 'vehicleinfo';
  var carModelController = TextEditingController();
  var carColorController = TextEditingController();
  var vehicleNumberController = TextEditingController();

  void updateProfile(context){

    String id = currentFirebaseUser.uid;
    DatabaseReference driverRef =
    FirebaseDatabase.instance.reference().child('drivers/$id/vehicle_details');

    Map map = {
      'car_color': carColorController.text,
      'car_model': carModelController.text,
      'vehicle_number': vehicleNumberController.text,
    };

    driverRef.set(map);

    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[

              SizedBox(height: 20,),

              Image.asset('images/logo.png', height: 110, width: 110,),

              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 10,),

                    Text('Enter vehicle details', style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 22),),

                    SizedBox(height: 25,),

                    TextField(
                      controller: carModelController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Car Model',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                     ),
                    style: TextStyle(fontSize: 14.0),
                  ),

                    SizedBox(height: 10.0),

                    TextField(
                      controller: carColorController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Car color',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      controller: vehicleNumberController,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Vehicle number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 40.0,),

                    TaxiButton(
                      color: BrandColors.colorGreen,
                      title: 'PROCEED',
                      onPressed: (){

                        if(carModelController.text.length < 3){
                          showSnackBar('Please provide a valid car model');
                          return;
                        }

                        if(carColorController.text.length < 3){
                          showSnackBar('Please provide a valide car color');
                          return;
                        }

                        if(vehicleNumberController.text.length < 3){
                          showSnackBar('Please provide a valid vehicle number');
                          return;
                        }

                        updateProfile(context);

                        },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
