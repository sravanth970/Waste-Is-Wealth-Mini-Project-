import 'package:admin_project/Screens/databasemanager.dart';
import 'package:admin_project/Screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin_project/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final CollectionReference adminProfile =
    FirebaseFirestore.instance.collection("adminProfile");

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  final database = DatabaseManager();

  // Validating email
  String? validEmail(String email) {
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
  String? validPassword(String password) {
    if (password.isEmpty) {
      return "*This field is required.";
    } else if (!(password.length > 6)) {
      return "Password can't be less than 6 characters";
    } else {
      return null;
    }
  }

  // Validating confirm password
  String? validConfirmPassword(String cpassword, String password) {
    if (cpassword.isEmpty) {
      return "*This field is required.";
    } else if (password != cpassword) {
      return "Password doesn't match";
    } else {
      return null;
    }
  }

  // Validating Organisation
  String? validOrganisation(String organisation) {
    if (organisation.isEmpty) {
      return "*This field is required.";
    } else {
      return null;
    }
  }

  // Sign Up With Email, Password
  void signUp(String organisation, String email, String password,
      BuildContext context) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser.user != null) {
        await database.createAdmin(organisation, email, newUser.user!.uid);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const AdminLogin();
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
        msg: e.toString(),
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
            await adminProfile.doc(loginUser.user!.uid).get();
        if (doc['doorno'] == "" ||
            doc['state'] == "" ||
            doc['street'] == "" ||
            doc['town'] == "") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const AdminProfile();
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
          Navigator.pushNamed(context, "Dashboard");
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
        msg: e.toString(),
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
            return const AdminLogin();
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
        msg: e.toString(),
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
    auth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const AdminLogin();
        },
      ),
    );
  }

  // Getting Current Admin id
  String getAdminId() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }
}
