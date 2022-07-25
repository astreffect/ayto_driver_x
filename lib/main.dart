import 'package:ayto_driver_x/loginstate.dart';
import 'package:ayto_driver_x/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    /*initialRoute:
    FirebaseAuth.instance.currentUser == null ?"homepage":"Login",
    routes:
    {
    "homepage": (context) => const Home(),
    "login": (context)=>LoginScreen(),
    },*/
      home: LoginState(),
      debugShowCheckedModeBanner: false,
      color: Colors.indigo[900],
    );
  }
}
