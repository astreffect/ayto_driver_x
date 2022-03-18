import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ayto_driver_x/signup.dart';
import 'package:ayto_driver_x/mainpage.dart';
import 'package:ayto_driver_x/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginState extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<LoginState> with AfterLayoutMixin<LoginState> {

  FirebaseAuth auth = FirebaseAuth.instance;

  String srm="";
  final _database=FirebaseDatabase.instance.ref();
   int c=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeListeners();
  }
  void activeListeners(){
    final User? user=auth.currentUser;
    final id=user?.uid ;
    _database.child('Driver/${user?.uid}/FirstName').onValue.listen((event) {
      final Object? description=event.snapshot.value ?? false;
      setState(() {
        print('DescriptionLS=$description');
        srm='$description';
        print('SRMx1=$srm');

        if(srm.compareTo('false')==0) {
          c++;
        }
        rmn(srm);



      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(body: new Container(color: Colors.white));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.

        activeListeners();
  }

  void rmn(String s)
  {
    String ss=s;

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
      }
      else {

        print('User is signed in!');
        print('SRMxc=$ss');
        Fluttertoast.showToast(
          msg: srm,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if(ss.compareTo('false')==0||srm.compareTo('false')==0||c>0) {
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