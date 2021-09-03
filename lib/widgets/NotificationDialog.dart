import 'package:driverapp_project/brand_colors.dart';
import 'package:driverapp_project/datamodels/tripdetails.dart';
import 'package:driverapp_project/screens/newtripscreen.dart';
import 'package:driverapp_project/widgets/ProgressDialog.dart';
import 'package:driverapp_project/widgets/TaxiOutlineButton.dart';
import 'package:flutter/material.dart';


class NotificationDialog extends StatelessWidget {

 final TripDetails tripDetails;
 NotificationDialog({this.tripDetails});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SizedBox(height: 30.0,),

            Image.asset('images/taxi.png', width: 100,),

            SizedBox(height: 16.0,),

            Text('New Trip Request',
              style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),),

            SizedBox(height: 30.0,),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(

                children: <Widget>[

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/pickicon.png', height: 16, width: 16,),
                      SizedBox(width: 18,),

                      Expanded(child: Container(
                          child: Text("Jalgaon", style: TextStyle(
                              fontSize: 18),)))
                    ],
                  ),

                  SizedBox(height: 15,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/desticon.png', height: 16, width: 16,),
                      SizedBox(width: 18,),

                      Expanded(child: Container(
                          child: Text("Bhusawal", style: TextStyle(
                              fontSize: 18),)))
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),


            SizedBox(height: 8,),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        title: 'DECLINE',
                        color: BrandColors.colorLightGray,
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },

                      ),
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        title: 'ACCEPT',
                        color: BrandColors.colorGreen,
                        onPressed: () async {
                          checkAvailablity(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewTripPage(),)
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }


  void checkAvailablity(context){

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Accepting request',),
    );
    Navigator.pop(context);
    Navigator.pop(context);


  }


}








