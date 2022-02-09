import 'package:familytracker/MaazCode/listen_location.dart';
import 'package:flutter/material.dart';
import 'package:familytracker/MaazCode/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListenLocationWidget(),
    );
  }
}
