import 'package:flutter/material.dart';
import 'package:project/screens/authentication.dart';

final authCheck = Authentication();

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 25.0, right: 16.0),
        child: ListView(
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person_outline_rounded,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15.0,
              thickness: 2.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                authCheck.forgotPassword(authCheck.getUserMail(), context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            // buildAccountSettings("Change Password"),
            // buildAccountSettings("Content Settings"),
            // buildAccountSettings("Language"),
            // buildAccountSettings("Privacy and Security"),
            const SizedBox(
              height: 200.0,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  authCheck.signOut(context);
                },
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GestureDetector buildAccountSettings(String title) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.grey,
  //             ),
  //           ),
  //           const Icon(
  //             Icons.arrow_forward_ios,
  //             color: Colors.grey,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
}
