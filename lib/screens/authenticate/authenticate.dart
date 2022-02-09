import 'package:familytracker/Introduction/introduction.dart';
import 'package:familytracker/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // bool showSignIn = true;
  // void toggleView(){
  //   //print(showSignIn.toString());
  //   setState(() => showSignIn = !showSignIn);
  // }
  bool initialized = false;
  bool loading =true;
  Future getvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      initialized = prefs.getBool('initialized') ?? false;
    });
     //initialized = prefs.getBool('initialized') ?? false;
     prefs.setBool('initialized',true);
  }

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }
  @override
  void initState() {
    super.initState();
    getvalues();

  }
  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return OnBoardingPage(toggleView:  toggleView);

    } else {
      if (showSignIn) {
        return LoginPage(toggleView:  toggleView);
      } else {
        return OnBoardingPage(toggleView:  toggleView);
      }
    }
  }
}