import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Screens/Login/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/Screens/Profile/profile.dart';
import 'package:project/Screens/Start/start.dart';
import 'package:project/Screens/databasemanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final CollectionReference userProfile =
    FirebaseFirestore.instance.collection("userProfile");

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  final database = DatabaseManager();

  // Validating name
  String validName(String name) {
    if (name.isEmpty) {
      return "*This field is required.";
    } else {
      return null;
    }
  }

  // Validating phone
  String validMobile(String phone) {
    if (phone.isEmpty) {
      return "*This field is required.";
    } else if (!(phone.length == 10)) {
      return "Please Enter Valid Contact";
    } else {
      return null;
    }
  }

  // Validating email
  String validEmail(String email) {
    if (email.isEmpty) {
      return "*This field is required.";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "This Email is badly formatted.";
    } else {
      return null;
    }
  }

  // Validating password
  String validPassword(String password) {
    if (password.isEmpty) {
      return "*This field is required.";
    } else if (!(password.length > 6)) {
      return "Password can't be less than 6 characters";
    } else {
      return null;
    }
  }

  // Validating confirm password
  String validConfirmPassword(String cpassword, String password) {
    if (cpassword.isEmpty) {
      return "*This field is required.";
    } else if (password != cpassword) {
      return "Password doesn't match";
    } else {
      return null;
    }
  }

  // Google Sign In
  Future signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential newUser = await auth.signInWithCredential(credential);

      await database.createUser("", newUser.user.email, newUser.user.uid, "");

      if (newUser.user != null) {
        Fluttertoast.showToast(
          msg: "Login Sucessful. Update your profile.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', newUser.credential.toString());
      }

      return Future.value(true);
    }
  }

  // Sign Up With Email, Password
  void signUp(String name, String phone, String email, String password,
      BuildContext context) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser.user != null) {
        await database.createUser(name, email, newUser.user.uid, phone);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Login();
            },
          ),
        );
        Fluttertoast.showToast(
          msg: "Successfully Registered.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  // Login with Email, Password
  void signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential loginUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (loginUser.user != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', email);
        final DocumentSnapshot doc =
            await userProfile.doc(loginUser.user.uid).get();
        if (doc['doorno'] == "" ||
            doc['state'] == "" ||
            doc['street'] == "" ||
            doc['town'] == "") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Profile();
              },
            ),
          );
          Fluttertoast.showToast(
            msg: "Login Sucessful. Update your profile.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        } else {
          Navigator.pushNamed(context, "Home");
          Fluttertoast.showToast(
            msg: "Login Sucessful.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  // Forgot Password and Reset Password
  void forgotPassword(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Login();
          },
        ),
      );
      Fluttertoast.showToast(
        msg: "Mail has been sent to reset your password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  // Sign Out
  void signOut(BuildContext context) async {
    final user = auth.currentUser;

    if (user.providerData[0].providerId == 'google.com') {
      googleSignIn.disconnect();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('email');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Start();
          },
        ),
      );
    } else {
      auth.signOut();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('email');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const Start();
      }));
    }
  }

  // Getting Current Admin id
  String getUserId() {
    final User user = auth.currentUser;
    final uid = user.uid;
    return uid;
  }

  // Getting Current User Mail ID
  String getUserMail() {
    final User user = auth.currentUser;
    final mail = user.email;
    return mail;
  }
}
