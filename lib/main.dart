import 'package:driverapp_project/screens/login.dart';
import 'package:driverapp_project/screens/mainpage.dart';
import 'package:driverapp_project/screens/registration.dart';
import 'package:driverapp_project/screens/vehicleinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'globalvariabels.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    // ignore: Unused_local_variable

  final FirebaseApp app = await Firebase.initializeApp(
      name: 'db2',
      options:  FirebaseOptions(
        appId: '1:1077846897323:android:5878755665fbf251cafdee',
        apiKey: 'AIzaSyD5NuKqAzz2qlyqZq_sJ5ZXQeWAjgFl4Bk',
        projectId: 'agritransport-10f46',
        messagingSenderId: '1077846897323',
        databaseURL: 'https://agritransport-10f46-default-rtdb.firebaseio.com',
      ),
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: (currentFirebaseUser == null) ? LoginPage.id : MainPage.id,
      routes: {
        MainPage.id: (context) => MainPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        VehicleInfoPage.id: (context) => VehicleInfoPage(),
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}

