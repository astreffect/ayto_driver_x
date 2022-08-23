import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookingInterface extends StatefulWidget {
  const BookingInterface({Key? key}) : super(key: key);

  @override
  State<BookingInterface> createState() => _BookingInterfaceState();
}

class _BookingInterfaceState extends State<BookingInterface> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  //var phoneController = TextEditingController();
  var emailController = TextEditingController();

  get id => null;

  void Bis() async {
    final User user = _auth.currentUser!;
    final id = user.uid;

    DatabaseReference dref =
    FirebaseDatabase.instance.ref().child("Booking/${user.uid}");
    Map map = {
      'uid':id,
      'ld_State':2
    };
    dref.set(map);
  }
  void test()
  {
    if (id.toString().compareTo('1')==0)
    {
      //Booking Successful
    }
    else
    {
      //Booking Unsuccessful
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
