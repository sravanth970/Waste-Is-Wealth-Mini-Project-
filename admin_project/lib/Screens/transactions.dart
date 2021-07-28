import 'package:admin_project/Screens/donetransactions.dart';
import 'package:admin_project/Screens/todotransactions.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Widget> _pages = [
    const ToDoTransactions(),
    const DoneTransactions(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Transactions",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "UnDone",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Done",
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
