import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ayto_driver_x/signup.dart';
import 'package:ayto_driver_x/mainpage.dart';
import 'package:ayto_driver_x/login.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'After Layout - Good Example',
      home: new LoginState(),
    );
  }
}

class LoginState extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<LoginState> with AfterLayoutMixin<LoginState> {

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";
  String srm="";
  final _database=FirebaseDatabase.instance.ref();
//int c=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeListeners();
  }
  void _activeListeners(){
    final User? user=auth.currentUser;
    final id=user?.uid ;
    _database.child('Driver/${user?.uid}/FirstName').onValue.listen((event) {
      final Object? description=event.snapshot.value ?? false;
      setState(() {
        print('Description=$description');
        srm='$description';
        /*if (description == null) {
          // Safe
          c=0;
        }
        else
          {
            c=1;
            //srm='$description' ?? "false";
          }*/
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(color: Colors.red));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    rmn();
  }

  void rmn()
  {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(
            builder: (context) => LoginScreen(),

          ),
              (e) => false,
        );
      } else {
        print('User is signed in!');
        if(srm.compareTo('false')==0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ),
          );

        }
        else {
          Navigator.pushAndRemoveUntil(
            context,

            MaterialPageRoute(
              builder: (context) => const MainPage(),

            ),
                (e) => false,
          );


        }
      }
    });

  }
}