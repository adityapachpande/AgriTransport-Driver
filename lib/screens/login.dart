
import 'package:connectivity/connectivity.dart';
import 'package:driverapp_project/brand_colors.dart';
import 'package:driverapp_project/screens/mainpage.dart';
import 'package:driverapp_project/screens/registration.dart';
import 'package:driverapp_project/widgets/ProgressDialog.dart';
import 'package:driverapp_project/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {

  static const String id = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    // show wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Ready to log you in',),
    );


    final user  = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){
      //for checking error and displaying it
      Navigator.pop(context);
      PlatformException thisEx =ex;
      showSnackBar(thisEx.message);

    })).user;


    if(user != null) {
      // login verification
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('drivers/${user.uid}');

      userRef.once().then((DataSnapshot snapshot)
      {
        if(snapshot.value != null)
        {
          Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [

                SizedBox(height: 70,),
                Image(
                    alignment: Alignment.center,
                    height: 150,
                    width: 120,
                    image: AssetImage('images/logo.png')
                ),

                SizedBox(height: 40,),
                Text('Login as a driver',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController ,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontSize: 14.00,
                            )
                        ),
                        style:TextStyle(fontSize: 14.0),
                      ),

                      SizedBox(height: 10,),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.00,
                            )
                        ),
                        style:TextStyle(fontSize: 14.0),

                      ),

                      SizedBox(height: 40,),

                      TaxiButton(           // Using button as a function
                        title: 'LOGIN',
                        color: BrandColors.colorAccentPurple,
                        onPressed:() async {
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No Internet Connection');
                            return;
                          }

                          if(!emailController.text.contains('@')){
                            showSnackBar('Please enter a valid email address');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Please enter a valid password');
                            return;
                          }
                          login();  //login method called here
                        },
                      ),
                    ],
                  ),
                ),

                // ignore: deprecated_member_use
                FlatButton(onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.id, (route) => false);
                },
                    child: Text('Don\'t have an account , sign up here')
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

