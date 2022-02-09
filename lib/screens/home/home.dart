import 'package:familytracker/SplashScreen/splashscreen.dart';
import 'package:familytracker/home/childhome.dart';
import 'package:familytracker/home/parenthome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {

  final String uid;
  Home({Key? key,required this.uid}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String usertype='';
  String famid='';
  //bool loading =true;


  Future getvalues() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.uid).get().then((DocumentSnapshot snapshot) {
        setState(() {
          usertype=snapshot.get('usertype').toString();
          famid=snapshot.get('familyid');
        });
        //print(usertype);
        //print(famid);
    });
    //return usertype;
  }

  @override
  void initState()  {
    super.initState();
    getvalues();
        //.whenComplete(() => setState((){loading=false;}));
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User?>(context);
    if(usertype=='child' && famid.isNotEmpty){
      return ChildHome(uid: widget.uid,famid: famid,);
    }
    else if(usertype=='parent'&& famid!=''){
      return ParentHome(famid: famid,);
    }
    return Splash();
    // if(loading){
    //   //print(getvalues());
    //   return Splash();
    // }
    // else{
    //   //print('in home');
    //
    //
    // }
  }
}
