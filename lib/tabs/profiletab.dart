import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileTab extends StatelessWidget {
  final String number = "1234567891";
  final String email = "abc11@gmail.com";

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Driver Information',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brand-Bold',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                Text(
                  'AgriTransport Driver',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Brand-Bold',
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.blueGrey,
                  ),
                ),



                Container(
                    color: Colors.white12,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(vertical: 13.0, horizontal: 28.0),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          child: Text(
                            "Name:  abc                                           ",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Brand-Bold',
                              color: Colors.black,
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        Card(
                          color: Colors.white,
                          child: Text(
                            "Mob:  $number                                ",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Brand-Bold',
                              color: Colors.black,
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        Card(
                          color: Colors.white,
                          child: Text(
                            "Email: $email                ",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Brand-Bold',
                              color: Colors.black,
                            ),
                          ),
                        ),

                      ],
                    )
                )
              ]
          ),
        )
    );
  }
}








