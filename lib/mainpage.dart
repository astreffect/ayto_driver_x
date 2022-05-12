import 'dart:async';

import 'package:ayto_driver_x/brand_colors.dart';
import 'package:ayto_driver_x/globalvariabels.dart';
//import 'package:cabdriver/tabs/earningstab.dart';
//import 'package:ayto_driver_x/tabs/hometab.dart';
import 'package:ayto_driver_x/tabs/profiletab.dart';
import 'package:ayto_driver_x/tabs/ratingstab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ayto_driver_x/progressdialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
  final FirebaseAuth _auth =FirebaseAuth.instance;
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};
  double x =0, y=0;
  late GoogleMapController mapController;
  //final Completer<GoogleMapController> _controller = Completer();
  double mapBottomPadding =0;
  //var geolocator =Geolocator();
  //late Position currentPosition;
  //late Position currentLocation;
  String OnOf="Online";
  Color myColour=Colors.red;
  void registerUser() async{
    final User user=_auth.currentUser!;
    final id=user.uid;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Registering you...',),
    );
    DatabaseReference dref = FirebaseDatabase.instance.ref().child("ONLINE/${user.uid}");
    Map map={
      'UID':id,
      'LAT':x,
      'LON':y,
      'state':1
    };
    dref.set(map);


    Navigator.pop(context);

  }

  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){

      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
        x = loc.latitude!;
        y = loc.longitude!;


      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getLocation();
    });
  }

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
            initialCameraPosition:CameraPosition(
              target: LatLng(x,y),
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller){
              _controller = controller;

              getLocation();

            },



         markers: _markers,
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

                GestureDetector(
                  onTap: () {
                    print("Tapped a Container");

                    setState(() {
                      if(OnOf.compareTo("Online")==0)
                      {
                        OnOf="Offline";
                        myColour=Colors.grey;
                        final User user=_auth.currentUser!;
                        final id=user.uid;

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => ProgressDialog(status: '0FFLINE SET...',),
                        );

                        DatabaseReference dref = FirebaseDatabase.instance.ref().child("ONLINE/${user.uid}");
                        Map map={
                          'UID':id,
                          'LAT':x,
                          'LON':y,
                          'state':0
                        };
                        dref.set(map);

                        Navigator.pop(context);

                      }
                      else{
                        OnOf="Online";
                        myColour=Colors.red;
                        final User user=_auth.currentUser!;
                        final id=user.uid;


                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => ProgressDialog(status: 'ONLINE SET...',),
                        );

                        DatabaseReference dref = FirebaseDatabase.instance.ref().child("ONLINE/${user.uid}");
                        Map map={
                          'UID':id,
                          'LAT':x,
                          'LON':y,
                          'state':1
                        };
                        dref.set(map);


                        Navigator.pop(context);

                      }
                       });
                  },
                    child:Container(
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
                        children:  [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.online_prediction,color: myColour,),
                          ),
                          SizedBox(
                            width: 22,

                          ),
                          Text('$OnOf'),


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


    )],
                ),
              ),


            ),
          )
        ],
      ),
    );
  }
}

