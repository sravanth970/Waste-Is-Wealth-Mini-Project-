import 'package:admin_project/Screens/checkedorders.dart';
import 'package:admin_project/Screens/databasemanager.dart';
import 'package:admin_project/Screens/uncheckedorders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference userOrders =
    FirebaseFirestore.instance.collection("userOrders");

class Deliveries extends StatefulWidget {
  const Deliveries({Key? key}) : super(key: key);

  @override
  _DeliveriesState createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  final database = DatabaseManager();

  final List<Widget> _pages = [
    const UncheckedOrders(),
    const CheckedOrders(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Deliveries",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "UnChecked",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Checked",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "AdminSettings");
              },
            ),
          ],
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}
