import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familytracker/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:familytracker/SplashScreen/showcards.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../theme.dart';

class ParentHome extends StatefulWidget {
  final String famid;

  ParentHome({required this.famid});

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  late final MapController mapcontroller;

  // mapcon
  final AuthService _auth = AuthService();
  double lat = 0.0;
  double long = 0.0;
  String Child = '';
  String Imagelink = '';
  var markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    mapcontroller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.famid)
            .where('usertype', isEqualTo: 'child')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              title: Text(
                'Hi, Parent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Colors.black
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.account_circle_rounded),
                onPressed: () async {
                  await _auth.signOut();
                },
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: (){
                      showmessagecard(context, 'Enter the Following code into the Childs app to register him' , Center(child: Text('${widget.famid}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)), Center());                    },
                    icon: Icon(Icons.add)
                )
              ],
            ),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //(lat==0.0&&long==0.0)?Container(child:Text('Please Select a Child by Tapping on its Image'))
                  Container(
                    height: 650,
                    //elevation: 10,
                    child: FlutterMap(
                      mapController: mapcontroller,
                      options: MapOptions(
                        //controller: mapcontroller,
                        center: LatLng(30.3753, 69.3451),

                        // onMapCreated: (mapcontroller){
                        //   mapcontroller.move(LatLng(0.0, 0.0), 3);
                        // },
                        maxZoom: 18,
                        zoom: 5.0,
                        minZoom: 3,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/maaztariq/ckxwxgc09073l14l5y4f94xt6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFhenRhcmlxIiwiYSI6ImNreHcwZHM5dzFxengydm8wZ2drdG9hMzEifQ.7NH_2PmHWHcyyGVsJHv1aQ",
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1IjoibWFhenRhcmlxIiwiYSI6ImNreHcwZHM5dzFxengydm8wZ2drdG9hMzEifQ.7NH_2PmHWHcyyGVsJHv1aQ',
                            'id': 'mapbox.mapbox-streets-v8',
                          },
                        ),
                        MarkerLayerOptions(markers: markers),
                      ],
                    ),
                  ),

                  Center(
                    child: SizedBox(
                        height: 128,
                        child: ListView.builder(
                          //physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: snapshot.data!.docs.map((e) {
                                Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                                Placemark address = Placemark();
                                geo
                                    .placemarkFromCoordinates(
                                         double.parse(data['lat'].toString()),
                                        double.parse(data['long'].toString()))
                                    .then((placemark) => setState(() {
                                          address = placemark[0];
                                        }));
                                markers.add(
                                  Marker(
                                    point: LatLng(double.parse(data['lat'].toString()),
                                        double.parse(data['long'].toString())),
                                    builder: (context) => InkWell(
                                      onTap: () {
                                        mapcontroller.move(
                                            LatLng(double.parse(data['lat'].toString()),
                                                double.parse(data['long'].toString())),
                                            15);
                                      },
                                      child: Container(
                                        //constraints: ConstrainedBox(constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),),
                                        width: 64.0,
                                        height: 64.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  e.get('imagelink')),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(128.0)),
                                          // border: Border.all(
                                          //   color: Colors.blue,
                                          //   width: 4.0,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                //Placemark address=Placemark();
                                //geo.placemarkFromCoordinates(double.parse(e.get('lat')), double.parse(e.get('long'))).then((placemark) => setState((){address=placemark[0];}));
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (address.country == null) {
                                      } else {
                                        showMenu(
                                          e.get('name'),
                                          address,
                                          e.get('imagelink'),
                                          double.parse(e.get('time')).toInt(),
                                          e.get('destination'),
                                          e.get('ping'),
                                          e.get('sos'),
                                          e.id,
                                        );
                                      }
                                      mapcontroller.move(
                                          LatLng(double.parse(data['lat'].toString()),
                                              double.parse(data['long'].toString())),
                                          15);
                                    },
                                    child: Container(
                                      //constraints: ConstrainedBox(constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),),
                                      width: 96.0,
                                      height: 96.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                e.get('imagelink')),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(128.0)),
                                        // border: Border.all(
                                        //   color: Colors.blue,
                                        //   width: 4.0,
                                        // ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()),
                        )),
                  ),

                  // ElevatedButton(
                  //     onPressed: () async {
                  //       await _auth.signOut();
                  //     },
                  //     child: Text('SOS')),
                  // Text('Parent Home')
                ],
              ),
            ),
          );
        });
  }

  showMenu(String Name, Placemark location, String imglink, int Time,
      String Destination, bool Ping, String SOSmessage, String ChildID) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            imglink,
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${Name}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${location.name}, ${location.subLocality}, ${location.locality}, ${location.administrativeArea}, ${location.country}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Last Updated: ${DateTime.fromMillisecondsSinceEpoch(Time)}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),

                  Center(
                    child: Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Destination: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        (Destination.isEmpty)
                            ? Text(
                                "No Destination Selected",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            : Text(
                                Destination,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                      ],
                    ),
                  ),

                  SOSmessage.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SOS Not Invoked',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SOS Message: ${SOSmessage}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                  (Ping == true)
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Waiting for Ping response',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            height: 56,
                            width: 112,
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  FirebaseFirestore.instance
                                      .collection(widget.famid)
                                      .doc(ChildID)
                                      .update({'ping': true});
                                  showmessagecard(
                                      context,
                                      'Waiting for Response',
                                      Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Colors.green,
                                        size: 64,
                                      ),
                                      Center());
                                },
                                borderRadius: BorderRadius.circular(14.0),
                                child: Center(
                                  child: Text(
                                    'Send Ping',
                                    style:
                                        heading5.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  )
                  // trailing: MaterialButton(
                  //   color: Colors.red,
                  //   child: Text(
                  //     '',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
