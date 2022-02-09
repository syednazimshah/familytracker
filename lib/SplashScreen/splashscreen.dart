import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash.jpg",
              alignment: Alignment.center,
            ),
            Column(
              children: [
                Text('Family Tracker',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    )),
                SizedBox(height: 10,),
                Text('Track your family easily',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    )),
              ],
            ),

            SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            ),

          ],
        ));
  }
}
