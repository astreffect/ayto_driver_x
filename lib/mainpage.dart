import 'dart:async';

import 'package:ayto_driver_x/brand_colors.dart';
import 'package:ayto_driver_x/globalvariabels.dart';
//import 'package:cabdriver/tabs/earningstab.dart';
//import 'package:ayto_driver_x/tabs/hometab.dart';
import 'package:ayto_driver_x/tabs/profiletab.dart';
import 'package:ayto_driver_x/tabs/ratingstab.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  _MaixnPageState createState() => _MainPageState();
}

class _MaixnPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  double mapBottomPadding = 0;
  var geolocator = Geolocator();
  late Position currentPosition;

  // TabController tabController;
  int selecetdIndex = 0;

  void setPositionlocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }



}

  void onItemClicked(int index){
    setState(() {
      selecetdIndex = index;
      //tabController.index = selecetdIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
   // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     /* body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
      /*  controller: tabController,
        children: <Widget>[
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],*/
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            title: Text('Earnings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Ratings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: selecetdIndex,
        unselectedItemColor: BrandColors.colorAccent,
        selectedItemColor: BrandColors.colorOrange,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}
