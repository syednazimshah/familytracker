import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familytracker/SplashScreen/splashscreen.dart';
import 'package:familytracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:familytracker/services/auth.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:familytracker/SplashScreen/showcards.dart';

class ChildHome extends StatefulWidget {

  final String uid;
  final String famid;

  ChildHome({required this.uid,required this.famid});

  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  final AuthService _auth = AuthService();

  bool initialized=false;

  listenfirebase() async {
  }

  final Location location = Location();
  bool enabled = true;
  LocationData? _location;
  StreamSubscription<LocationData>? _locationSubscription;
  String? _error;
  bool? _enabled;
  String? _error2;
TextEditingController _controller=TextEditingController();

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        setState(() {
          _error = err.code;
        });
      }
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((LocationData currentLocation) async{
      setState(() {
        _error = null;
        _location = currentLocation;
        //print(_location);
        //print(DateTime.fromMillisecondsSinceEpoch(_location!.time!.toInt()));
        //geo.placemarkFromCoordinates(_location!.latitude!, _location!.longitude!).then((placemark) => print(placemark[0].toString()));
      });
      //print('doc id is $docid');
      await FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).update({'time': _location!.time!.toString(),'lat':_location!.latitude!.toDouble(), 'long':_location!.longitude!.toDouble() });
    });
    setState(() {});

  }
  @override
  void initState()  {
    super.initState();
    listenfirebase().whenComplete(() => _listenLocation().whenComplete(() => setState(() {
      initialized = true;
    })));
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              //return Error();
            }
            if (snapshot.connectionState == ConnectionState.none) {
              //return Error();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              //return Loading();
            }
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  title: Text('Hi, Child', style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(onPressed: () async {
                    await _auth.signOut();
                  }, icon: Icon(
                    Icons.account_circle_rounded, color: Colors.black,),),
                  actions: [
                    //todo
                  ],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      snapshot.data!.get('ping')?Container(
                        height: 56,
                        width: 256,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).update({'ping': false});
                                showmessagecard(context,'Ping responded Successfully',Icon(Icons.check_circle_outline_rounded,size: 50,color: Colors.green,), Center());
                              },
                              borderRadius: BorderRadius.circular(14.0),
                              child: Center(
                                child: Text(
                                  'Pings',
                                  style: heading5.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ):Column(),
                      Container(
                        height: 56,
                        width: 256,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).update({'sos': 'Emergency, Need help'});
                              },
                              borderRadius: BorderRadius.circular(14.0),
                              child: Center(
                                child: Text(
                                  'SOS, Emergency',
                                  style: heading5.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 56,
                        width: 256,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {

                                showmessagecard(context, 'Enter', Text('Enter your Destination'),Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: textWhiteGrey,
                                        borderRadius: BorderRadius.circular(14.0),
                                      ),
                                      child: TextFormField(
                                        controller: _controller,
                                        decoration: InputDecoration(
                                          hintText: 'Destination',
                                          hintStyle: heading6.copyWith(color: textGrey),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: primaryBlue,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).update({
                                          'destination':_controller.text
                                        });
                                        Navigator.pop(context);
                                        showmessagecard(context, 'Successful', Icon(Icons.check_circle_outline_rounded,size: 50,color: Colors.green,), Center());
                                      },
                                      borderRadius: BorderRadius.circular(14.0),
                                      child: Center(
                                        child: Text(
                                          'Set destination',
                                          style: heading5.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                  ],
                                ),)
                                );
                                FirebaseFirestore.instance.collection(widget.famid).doc(widget.uid).update({'sos': 'Emergency, Need help'});
                              },
                              borderRadius: BorderRadius.circular(14.0),
                              child: Center(
                                child: Text(
                                  'Set Destination',
                                  style: heading5.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ));
          }
      );
    }
    else{
      print('in child');
      return Splash();
    }
  }
}
