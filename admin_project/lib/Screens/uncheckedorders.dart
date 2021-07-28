import 'package:admin_project/Screens/databasemanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference userOrders =
    FirebaseFirestore.instance.collection("userOrders");

class UncheckedOrders extends StatefulWidget {
  const UncheckedOrders({Key? key}) : super(key: key);

  @override
  _UncheckedOrdersState createState() => _UncheckedOrdersState();
}

class _UncheckedOrdersState extends State<UncheckedOrders> {
  final database = DatabaseManager();

  dynamic selectedChoice;
  List items = ["Accepted", "Rejected"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("userOrders")
            .where("materialTest", isEqualTo: "")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ordersData = snapshot.data!.docs[index];
              int weight = ordersData['weight'];
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                          ordersData['factory'],
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
                              ordersData['category'],
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
                          ordersData['userName'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DropdownButton(
                          hint: const Text("Set Material Test Status"),
                          value: selectedChoice,
                          items: items.map((newValue) {
                            return DropdownMenuItem(
                              child: Text(
                                newValue,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: newValue,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedChoice = newValue;
                            });
                          },
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                              ),
                              onPressed: () {
                                database.showOrderDetails(
                                    context, snapshot.data!.docs[index].id);
                              },
                              child: const Text(
                                "View Details",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: 2.2,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 45.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                database.updateUserOrders(selectedChoice,
                                    snapshot.data!.docs[index].id);
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                primary: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
