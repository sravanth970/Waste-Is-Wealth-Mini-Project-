import 'package:admin_project/Screens/dashboard.dart';
import 'package:admin_project/Screens/deliveries.dart';
import 'package:admin_project/Screens/factories.dart';
import 'package:admin_project/Screens/settings.dart';
import 'package:admin_project/Screens/login.dart';
import 'package:admin_project/Screens/transactions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic email;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('email');
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: email == null ? const AdminLogin() : const Dashboard(),
      routes: {
        "Dashboard": (context) => const Dashboard(),
        "Add Factories": (context) => const Factories(),
        "Deliveries": (context) => const Deliveries(),
        "AdminSettings": (context) => const AdminSettings(),
        "Transactions": (context) => const Transactions(),
      },
    );
  }
}
