import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/screens/register/register.dart';
import 'package:project/screens/authentication.dart';
import 'package:project/screens/bottom_navigation.dart';

class Start extends StatefulWidget {
  const Start({Key key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final authCheck = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 45.0,
          ),
          const Image(
            image: AssetImage('assets/images/start.png'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          RichText(
            text: const TextSpan(
              text: 'Welcome',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Login();
                      },
                    ),
                  );
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.green,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Register();
                      },
                    ),
                  );
                },
                child: const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () {
              authCheck.signInWithGoogle(context).whenComplete(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const NavigationBar();
                        },
                      ),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
