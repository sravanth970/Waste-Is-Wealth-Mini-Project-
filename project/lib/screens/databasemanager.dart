import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseManager {
  // User Profile Collection
  final CollectionReference userprofile =
      FirebaseFirestore.instance.collection("userProfile");

  // User Orders Collection
  final CollectionReference userOrders =
      FirebaseFirestore.instance.collection("userOrders");

  // Storing User Details whenever created
  Future createUser(String name, String email, String uid, String phone) async {
    return await userprofile.doc(uid).set({
      'name': name,
      'email': email,
      'doorno': "",
      'street': "",
      'town': "",
      'state': "",
      'phone': phone,
    });
  }

  // Adding User Orders to the firebase
  addUserOrders(BuildContext context, String category, int weight,
      String factory, String userID) async {
    final DocumentSnapshot doc = await userprofile.doc(userID).get();

    await userOrders.doc().set({
      "userID": userID,
      "category": category,
      "userName": doc['name'],
      "userContact": doc['phone'],
      "userEmail": doc['email'],
      "userAddress": doc['doorno'] +
          "," +
          doc['street'] +
          "," +
          doc['town'] +
          "," +
          doc['state'],
      "weight": weight,
      "factory": factory,
      "materialTest": "",
      "amount": -1,
    });
    Fluttertoast.showToast(
      msg: "Order Placed",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
    Navigator.pushNamed(context, "Past Orders");
  }
}
