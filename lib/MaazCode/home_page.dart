import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapController mapController = MapController();

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: lat_lng.LatLng(51.5074, 0.1278),
          zoom: 16.0,
          minZoom: 10,
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
          MarkerLayerOptions(
            markers: [
              Marker(
                  width: 80.0,
                  height: 80.0,
                  point: lat_lng.LatLng(51.5074, 0.1278),
                  builder: (context) => Container(
                        child: const FlutterLogo(),
                      )),
            ],
          ),
          //userLocationOptions,
        ],
        mapController: mapController,
      ),
    );
  }
}
