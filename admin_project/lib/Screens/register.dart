import 'package:admin_project/Screens/authentication.dart';
import 'package:admin_project/Screens/login.dart';
import 'package:flutter/material.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({Key? key}) : super(key: key);

  @override
  _AdminRegisterState createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final TextEditingController _organisation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final authCheck = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 60.0, 0.0, 0.0),
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(280.0, 60.0, 0.0, 0.0),
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
              padding: const EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _organisation,
                        scrollPadding: const EdgeInsets.only(bottom: 40.0),
                        decoration: const InputDecoration(
                          labelText: "Organisation",
                          prefixIcon: Icon(
                            Icons.corporate_fare,
                            color: Colors.grey,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return authCheck
                              .validOrganisation(_organisation.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _email,
                        scrollPadding: const EdgeInsets.only(bottom: 40.0),
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return authCheck.validEmail(_email.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _password,
                        scrollPadding: const EdgeInsets.only(bottom: 40.0),
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.grey,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          return authCheck.validPassword(_password.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _confirmpassword,
                        scrollPadding: const EdgeInsets.only(bottom: 40.0),
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.grey,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          return authCheck.validConfirmPassword(
                              _confirmpassword.text, _password.text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 70.0,
                      width: 320.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authCheck.signUp(_organisation.text, _email.text,
                            _password.text, context);
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already Member ?',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const AdminLogin();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
