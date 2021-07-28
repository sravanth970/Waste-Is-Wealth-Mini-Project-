import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class DatabaseManager {
  // Admin Profile Collection
  final CollectionReference adminprofile =
      FirebaseFirestore.instance.collection("adminProfile");

  // User Order Collection
  final CollectionReference userOrder =
      FirebaseFirestore.instance.collection("userOrders");

  String orderDocID = "";

  // Storing Admin Details whenever created
  Future createAdmin(String organisation, String email, String uid) async {
    return await adminprofile.doc(uid).set({
      'organisation': organisation,
      'email': email,
      'doorno': "",
      'street': "",
      'town': "",
      'state': "",
      'phone': "",
    });
  }

  // Adding Factories to Categories
  void addFactory(String category, List<String> details) async {
    final CollectionReference factoryCollection =
        FirebaseFirestore.instance.collection(category);
    await factoryCollection.doc().set({
      "name": details[0],
      "doorno": details[1],
      "street": details[2],
      "town": details[3],
      "state": details[4],
    });
    Fluttertoast.showToast(
      msg: "Factory Added",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  // Updating
  void editFactory(String category, String docID, List details) async {
    final CollectionReference factoryCollection =
        FirebaseFirestore.instance.collection(category);
    await factoryCollection.doc(docID).update({
      "name": details[0],
      "doorno": details[1],
      "street": details[2],
      "town": details[3],
      "state": details[4],
    });
    Fluttertoast.showToast(
      msg: "Factory Updated",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  // Deleting Factory Details from a particular Category
  void deleteFactory(String category, String docId) {
    final CollectionReference factoryCollection =
        FirebaseFirestore.instance.collection(category);
    try {
      factoryCollection.doc(docId).delete();
      Fluttertoast.showToast(
        msg: "Factory Deleted",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  // Update User Order Details
  updateUserOrders(String materialTest, String docID) async {
    await userOrder.doc(docID).update({'materialTest': materialTest});
    if (materialTest == 'Rejected') {
      await userOrder.doc(docID).update({'amount': 0});
    }
    Fluttertoast.showToast(
      msg: "Material Status Updated",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  updateAmount(String amount, String docID) async {
    await userOrder.doc(docID).update({'amount': int.parse(amount)});
    Fluttertoast.showToast(
      msg: "Amount Updated",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  // Show Details of the Order
  void showOrderDetails(BuildContext context, String docID) async {
    final DocumentSnapshot doc = await userOrder.doc(docID).get();

    String userName = doc['userName'];
    String userEmail = doc['userEmail'];
    String userContact = doc['userContact'];
    List userAddress = doc['userAddress'].split(",");
    String category = doc['category'];
    String factory = doc['factory'];
    int weight = doc['weight'];
    int amount = doc['amount'];
    String materialStatus = doc['materialTest'];

    buildOrderDetails(docID, userName, userEmail, userContact, userAddress,
        category, factory, weight, materialStatus, amount, context);
  }

  Future buildOrderDetails(
      String docID,
      String name,
      String email,
      String contact,
      List address,
      String category,
      String factory,
      int weight,
      String materialStatus,
      int amount,
      BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: const Center(
              child: Text("Order Details"),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Organisation: ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    factory,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Category: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        category,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Text(
                        "Weight(in kgs): ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '$weight',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Material Test Status: ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    materialStatus,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  amount != -1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Amount Sent (in Rs.): ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Rs. $amount ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          "Amount not yet transferred",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "User: ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    contact,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Address: ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    address[0],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    address[1],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    address[2],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    address[3],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.green,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 35.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
