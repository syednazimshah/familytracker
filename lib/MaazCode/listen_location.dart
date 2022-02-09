import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter/services.dart';
import 'package:location/location.dart';


class ListenLocationWidget extends StatefulWidget {
  const ListenLocationWidget({Key? key}) : super(key: key);

  @override
  _ListenLocationState createState() => _ListenLocationState();
}

class _ListenLocationState extends State<ListenLocationWidget> {
  final Location location = Location();
  bool enabled = true;
  LocationData? _location;
  StreamSubscription<LocationData>? _locationSubscription;
  String? _error;
  bool? _enabled;
  String? _error2;

  Future<void> _enableBackgroundMode() async {
    setState(() {
      _error2 = null;
    });
    try {
      final bool result =
      await location.enableBackgroundMode(enable: true);
      setState(() {
        _enabled = result;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error2 = err.code;
      });
    }
  }

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
        }).listen((LocationData currentLocation){
          setState(() {
            _error = null;
            _location = currentLocation;
            print(_location);
            print(DateTime.fromMillisecondsSinceEpoch(_location!.time!.toInt()));
            geo.placemarkFromCoordinates(_location!.latitude!, _location!.longitude!).then((placemark) => print(placemark[0].toString()));
          });
        });
    setState(() {});

  }

  Future<void> _stopListen() async {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Listen location: ' + (_error ?? '${_location ?? "unknown"}'),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                child: const Text('Listen'),
                onPressed:
                 // if (location.isBackgroundModeEnabled() == false){
                 //   _enableBackgroundMode();
                 // }
                  _locationSubscription == null ? _listenLocation : null,
                ),
            ),
            ElevatedButton(
              child: const Text('Stop'),
              onPressed: _locationSubscription != null ? _stopListen : null,
            )
          ],
        ),
      ],
    );
  }
}