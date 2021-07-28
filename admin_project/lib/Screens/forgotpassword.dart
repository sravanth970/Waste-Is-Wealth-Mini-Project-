import 'package:flutter/material.dart';

class AdminForgotPassword extends StatefulWidget {
  const AdminForgotPassword({Key? key}) : super(key: key);

  @override
  _AdminForgotPasswordState createState() => _AdminForgotPasswordState();
}

class _AdminForgotPasswordState extends State<AdminForgotPassword> {
  final TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(25.0, 90.0, 0.0, 0.0),
                child: const Text(
                  'Forgot',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(27.0, 155.0, 0.0, 0.0),
                child: const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(290.0, 150.0, 0.0, 0.0),
                child: const Text(
                  '!',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 90.0,
                    width: 320.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'RESET',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
