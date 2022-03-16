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

import 'mydrawer.dart';

class MainPage extends StatefulWidget {
  //final User user;
  // ignore: use_key_in_widget_constructors
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldkey= GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  double mapBottomPadding =0;
  var geolocator =Geolocator();
  late Position currentPosition;

  void setPositionlocator() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude,position.longitude);
    CameraPosition cp = CameraPosition(target: pos,zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));


  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldkey,
      drawer: const MyDrawer(),
      body: Stack(
        children:  [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              mapController= controller;
              setState(() {
                mapBottomPadding= 250;
              });
              setPositionlocator();

            },

          ),
          //drawer
          Positioned(
            top: 44,
            left: 15,
            child: GestureDetector(
              onTap: (){
                scaffoldkey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [ BoxShadow(
                        color:Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        )
                    )]

                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: Icon(Icons.menu, color: Colors.black26,),
                ),
              ),
            ),
          ),
          //search
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 220,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                  boxShadow:[ BoxShadow(
                      color:  Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7)

                  )]

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 5.0,),

                    const SizedBox(height: 20,),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          // color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow:[ BoxShadow(
                              color:  Colors.black26,
                              blurRadius: 15.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7)), ]
                      ),
                      child: Row(
                        children: const [



                        ],
                      ),),
                    const SizedBox(height: 22,),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow:[ BoxShadow(
                              color:  Colors.black26,
                              blurRadius: 15.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7)), ]
                      ),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.online_prediction,color: Colors.red,),
                          ),
                          SizedBox(width: 22,),
                          Text("Online"),

                        ],
                      ),),
                    //   SizedBox(height: 22,),
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       color: BrandColors.button,
                    //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //       boxShadow:[ BoxShadow(
                    //           color:  Colors.black26,
                    //           blurRadius: 15.0,
                    //           spreadRadius: 0.5,
                    //           offset: Offset(0.7, 0.7)), ]
                    //   ),
                    //   child: Row(
                    //     children: const [
                    //       Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: Icon(Icons.home,color: Colors.black,),
                    //       ),
                    //       SizedBox(width: 22,),
                    //       Text("Home"),
                    //
                    //     ],
                    //   ),),


                  ],
                ),
              ),


            ),
          )
        ],
      ),
    );
  }
}

