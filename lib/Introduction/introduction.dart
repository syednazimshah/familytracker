import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familytracker/login_page.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:familytracker/theme.dart';
import 'package:familytracker/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:familytracker/SplashScreen/showcards.dart';
class OnBoardingPage extends StatefulWidget {
  final Function toggleView;
  OnBoardingPage({ required this.toggleView });
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController usertype = TextEditingController();

  //bool initialized = false;
  late File _imageFile;
  bool imagetaken = false;
  bool passwordVisible = false;
  bool ismakefamilyselected = false;
  bool passwordConfrimationVisible = false;
  TextEditingController familycode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

 

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: [
            PageViewModel(
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Family Locator',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
              ),
              image: Image.asset(
                'assets/splash.jpg',
                fit: BoxFit.fitWidth,
              ),
              bodyWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lets get you Set up',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_sharp,
                    size: 20,
                    color: Colors.grey,
                  )
                ],
              ),
              decoration: PageDecoration(bodyAlignment: Alignment.center),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Select your Role',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ),
              bodyWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          usertype.text = 'parent';
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: Image.asset(
                          'assets/parent.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 56,
                      width: 256,
                      decoration: BoxDecoration(
                        color: (usertype.text == 'parent')
                            ? primaryBlue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              usertype.text = 'parent';
                            });
                          },
                          borderRadius: BorderRadius.circular(14.0),
                          child: Center(
                            child: Text(
                              'Parent',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          usertype.text = 'child';
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: Image.asset(
                          'assets/child.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 56,
                      width: 256,
                      decoration: BoxDecoration(
                        color: (usertype.text == 'child')
                            ? primaryBlue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              usertype.text = 'child';
                            });
                          },
                          borderRadius: BorderRadius.circular(14.0),
                          child: Center(
                            child: Text(
                              'Child',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
              decoration: PageDecoration(bodyAlignment: Alignment.center),
            ),
            PageViewModel(
                titleWidget: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('Create an Account',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold)),
                ),
                decoration: PageDecoration(bodyAlignment: Alignment.center),
                bodyWidget: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Column(
                    //padding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                obscureText: !passwordVisible,
                                controller: pass,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  suffixIcon: IconButton(
                                    color: textGrey,
                                    splashRadius: 1,
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                obscureText: !passwordConfrimationVisible,
                                controller: confirmpass,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  suffixIcon: IconButton(
                                    color: textGrey,
                                    splashRadius: 1,
                                    icon: Icon(passwordConfrimationVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        passwordConfrimationVisible =
                                            !passwordConfrimationVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: regular16pt.copyWith(color: textGrey),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Login',
                              style: regular16pt.copyWith(color: primaryBlue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            PageViewModel(
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Enter Your Information',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ),
              decoration: PageDecoration(bodyAlignment: Alignment.center),
              bodyWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                controller: address,
                                decoration: InputDecoration(
                                  hintText: 'Address',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: phone,
                                decoration: InputDecoration(
                                  hintText: (usertype.text == 'parent')
                                      ? 'Phone'
                                      : 'Emergency Contact Phone',
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            PageViewModel(
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Add a Picture',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ),
              decoration: PageDecoration(bodyAlignment: Alignment.center),
              bodyWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      !imagetaken
                          ? Icon(
                              Icons.account_circle_rounded,
                              size: 256,
                              color: Colors.grey,
                            )
                          : Center(
                              child: Container(
                                width: 256.0,
                                height: 256.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: FileImage(File(_imageFile.path)),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(128.0)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 4.0,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 42,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 42,
                            width: 128,
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera,
                                          maxWidth: 1080,
                                          maxHeight: 1080,
                                          preferredCameraDevice:
                                              CameraDevice.rear);

                                  setState(() {
                                    _imageFile = File(pickedFile!.path);
                                    imagetaken = true;
                                  });
                                },
                                borderRadius: BorderRadius.circular(14.0),
                                child: Center(
                                  child: Text(
                                    'Camera',
                                    style:
                                        heading5.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(height: 20,),
                          Column(
                            children: [
                              Container(
                                height: 42,
                                width: 128,
                                decoration: BoxDecoration(
                                  color: primaryBlue,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      final pickedFile = (await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery))!;
                                      setState(() {
                                        _imageFile = File(pickedFile.path);
                                        imagetaken = true;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Center(
                                      child: Text(
                                        'Gallery',
                                        style: heading5.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),















            PageViewModel(
              titleWidget: Text(''),
              bodyWidget: Center(
                child: Column(
                  children: [

                    usertype.text=='parent'?Column(
                        children: [
                          Text('If a family has not been created',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text('Click to create it',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: Image.asset(
                              "assets/family2.jpg",
                              alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          Center(
                            child: Container(
                              height: 42,
                              width: 256,
                              decoration: BoxDecoration(
                                color: !ismakefamilyselected?Colors.grey:primaryBlue,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      ismakefamilyselected=!ismakefamilyselected;
                                    });


                                  },
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Center(
                                    child: Text(
                                      'Create a Family',
                                      style: heading5.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 64,
                          ),
                          Text('If your family has been created.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ],
                      ):Column(),

                    Column(
                        children: [
                          Text('Join your Family using Family Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: Image.asset(
                              "assets/manhi.jpg",
                              alignment: Alignment.center,
                            ),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          Container(
                            height: 56,
                            width: 280,
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: familycode,
                              decoration: InputDecoration(
                                hintText: 'Family Code',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),

                        ],
                      ),

                  ],
                ),
              ),
            )
          ],




































          //freeze: true,
          done: Text('Finish',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.blue)),
          onDone: () async {
            String message = '';

            if (usertype.text.isEmpty) {
              setState(() {
                message = 'Please select Your User Type\nChild or Parent';
              });
              showmessagecard(context,
                  message,
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 64,
                  ),
                  Center());
            } else if (name.text.isEmpty ||
                address.text.isEmpty ||
                phone.text.isEmpty) {
              setState(() {
                message = 'Your Information is incomplete';
              });
              showmessagecard(context,
                  message,
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 64,
                  ),
                  Center());
            } else if (email.text.isEmpty ||
                pass.text.isEmpty ||
                confirmpass.text.isEmpty ||
                pass.text != confirmpass.text) {
              setState(() {
                message = 'Email or Password Error';
              });
              showmessagecard(context,
                  message,
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 64,
                  ),
                  Center());
            } else if (!imagetaken) {
              setState(() {
                message = 'Please Provide an Image for your Profile';
              });
              showmessagecard(context,
                  message,
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 64,
                  ),
                  Center());
            } else if ((!ismakefamilyselected) && (familycode.text==''||familycode.text.isEmpty)) {
              setState(() {
                message = 'Please Enter a family code or choose to create a family';
              });
              showmessagecard(context,
                  message,
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 64,
                  ),
                  Center());
            }else {
              //Provider.of<User?>(context,listen: false);
              dynamic result = await _auth.registerWithEmailAndPassword(
                  email.text, pass.text);
              if (result is String) {
                if (result == 'weak-password') {
                  setState(() {
                    message = 'The password provided is too weak';
                  });
                  showmessagecard(context,
                      message,
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 64,
                      ),
                      Center());

                  //print('The password provided is too weak.');
                } else if (result == 'email-already-in-use') {
                  setState(() {
                    message = 'The account already exists for that email.';
                  });
                  showmessagecard(context,
                      message,
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 64,
                      ),
                      Center());
                  //print('The account already exists for that email.');
                } else {
                  setState(() {
                    message = result;
                  });
                  showmessagecard(context,
                      message,
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 64,
                      ),
                      Center());
                }
              } else{
                //print('here');
                String fileName = basename(_imageFile.path);
                print(fileName);
                Reference firebaseStorageRef = FirebaseStorage.instance
                    .ref()
                    .child('${email.text}/$fileName');
                UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
                TaskSnapshot taskSnapshot = await uploadTask;
                uploadTask.whenComplete(() {
                  taskSnapshot.ref.getDownloadURL().then(
                        (value) async {
                          if(ismakefamilyselected){
                            await FirebaseFirestore.instance
                                .collection('users').doc(result.uid)
                                .set(<String, dynamic>{
                              'name': name.text,
                              //'timestamp': DateTime.now(),
                              'address': address.text,
                              'phone': phone.text,
                              'email': email.text,
                              'usertype': usertype.text,
                              'imagelink': value.toString(),
                              'uid': result.uid.toString(),
                              'familyid':result.uid.toString(),
                              'time':'',
                              'lat':'',
                              'long':'',
                              'sos':'',
                              'destination':'',
                              'ping':false
                              // 'received': false,
                            });
                            await FirebaseFirestore.instance
                                .collection(result.uid).doc(result.uid)
                                .set(<String, dynamic>{
                              'name': name.text,
                              'uid': result.uid.toString(),
                              //'timestamp': DateTime.now(),
                              'address': address.text,
                              'phone': phone.text,
                              'email': email.text,
                              'usertype': usertype.text,
                              'imagelink': value.toString(),
                              'familyid':result.uid.toString(),
                              'time': '',
                              'lat':'',
                              'long':'',
                              'sos':'',
                              'destination':'',
                              'ping':false
                              // 'received': false,
                            });
                          }
                          else if(!familycode.text.isEmpty){
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(result.uid)
                                .set(<String, dynamic>{
                              'name': name.text,
                              //'timestamp': DateTime.now(),
                              'address': address.text,
                              'phone': phone.text,
                              'email': email.text,
                              'usertype': usertype.text,
                              'imagelink': value.toString(),
                              'uid': result.uid.toString(),
                              'familyid':familycode.text,
                              'time': '',
                              'lat':'',
                              'long':'',
                              'sos':'',
                              'destination':'',
                              'ping':false
                              // 'received': false,
                            });
                            await FirebaseFirestore.instance
                                .collection(familycode.text).doc(result.uid)
                                .set(<String, dynamic>{
                              'name': name.text,
                              'uid': result.uid.toString(),
                              //'timestamp': DateTime.now(),
                              'address': address.text,
                              'phone': phone.text,
                              'email': email.text,
                              'usertype': usertype.text,
                              'imagelink': value.toString(),
                              'familyid':familycode.text,
                              'time': '',
                              'lat':'',
                              'long':'',
                              'sos':'',
                              'destination':'',
                              'ping':false
                              // 'received': false,
                            });
                          }
                         // Provider.of<User?>(context,listen: true);
                    },
                  );
                });
              }
            }
          },

          showSkipButton: false,
          next: Icon(
            Icons.arrow_forward,
            color: Colors.blue,
          ),
          dotsDecorator: getDotDecoration(),
          skipFlex: 0,
          nextFlex: 0,
          showNextButton: true,
        ),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.blue,
        activeColor: Colors.blue,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );
}
