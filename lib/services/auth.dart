//import 'package:brew_crew/models/user.dart';
//import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  // User _userFromFirebaseUser(User user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  // auth change user stream
  Stream<User?> get user => _auth.authStateChanges();
  // Stream<User?> get user {
  //   return _auth.authStateChanges().listen((event) {});
  //
  //   // authStateChanges()
  //   // //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //   //     .map(_userFromFirebaseUser);
  // }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(result.user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return user;
    } catch (error) {
      // print(error.toString());
      return error.toString();
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      // create a new document for the user with the uid
      //await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return user;
    } catch (error) {
      // print(error.toString());
      return error.toString();
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

}