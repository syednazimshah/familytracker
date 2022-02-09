import 'package:familytracker/Introduction/introduction.dart';
import 'package:familytracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:familytracker/widgets/custom_checkbox.dart';
import 'theme.dart';
import 'package:familytracker/SplashScreen/showcards.dart';







class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({ required this.toggleView });
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  void getvalues(){

  }
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(25),
        children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to your\naccount',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/splash.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Form(
                child: Column(
                  children: [





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
                        controller: password,
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
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCheckbox(),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Remember me', style: regular16pt),
                ],
              ),
              SizedBox(
                height: 32,
              ),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async{
                  dynamic message = await _auth.signInWithEmailAndPassword(email.text, password.text);
                  if(message is String){
                    //print(message);
                    showmessagecard(context,
                        message,
                        Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: 64,
                        ),
                        Center());
                  }
                },
                borderRadius: BorderRadius.circular(14.0),
                child: Center(
                  child: Text(
                    'Login',
                    style: heading5.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
              // CustomPrimaryButton(
              //   buttonColor: primaryBlue,
              //   textValue: 'Login',
              //   textColor: Colors.white,
              // ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'OR',
                  style: heading6.copyWith(color: textGrey),
                ),
              ),
              SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}