//import 'package:familytracker/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familytracker/screens/authenticate/authenticate.dart';
import 'package:familytracker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  String usertype='';
  bool loading =true;


  // Future getvalues() async {
  //   FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: Provider.of<User?>(context)!.uid).get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       setState(() {
  //         usertype=doc['usertype'].toString();
  //       });
  //
  //     });
  //   });
  //   return usertype;
  // }

  @override
  void initState()  {
    super.initState();
    //getvalues().whenComplete(() => setState((){loading=false;}));
  }
  
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      //print(user.uid);
      return Home(uid: user.uid,);
    }

  }
}