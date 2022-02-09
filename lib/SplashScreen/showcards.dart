import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showloadingcard(context) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Please Wait',
                ),
              ),
            ),
            content: SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          );
        });
      });
}

showmessagecard(context,String message, Widget icon, Widget button) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Colors.white,
            actions: [
              button,
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: icon,
            ),
            content: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
      });
}