import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/Screens/authentication.dart';
import 'package:project/screens/bottom_navigation.dart';

final userRef = FirebaseFirestore.instance.collection("userProfile");

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  final auth = Authentication();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _doorno = TextEditingController();
  final TextEditingController _town = TextEditingController();
  final TextEditingController _state = TextEditingController();

  bool _emailValid = true;
  bool _nameValid = true;
  bool _phoneValid = true;
  bool _doornoValid = true;
  bool _townValid = true;
  bool _stateValid = true;
  bool _streetValid = true;

  void getUserData() async {
    String userId = auth.getUserId();

    final DocumentSnapshot doc = await userRef.doc(userId).get();

    _email.text = doc['email'];
    _name.text = doc['name'];
    _phone.text = doc['phone'];
    _doorno.text = doc['doorno'];
    _street.text = doc['street'];
    _town.text = doc['town'];
    _state.text = doc['state'];
  }

  void updateUserProfile() {
    // Checking for empty fields
    setState(() {
      _email.text.isEmpty ? _emailValid = false : _emailValid = true;
      _name.text.isEmpty ? _nameValid = false : _nameValid = true;
      _phone.text.isEmpty ? _phoneValid = false : _phoneValid = true;
      _doorno.text.isEmpty ? _doornoValid = false : _doornoValid = true;
      _street.text.isEmpty ? _streetValid = false : _streetValid = true;
      _state.text.isEmpty ? _stateValid = false : _stateValid = true;
      _town.text.isEmpty ? _townValid = false : _townValid = true;
    });

    // Updating the Profile of Admin
    if (_emailValid &&
        _nameValid &&
        _phoneValid &&
        _doornoValid &&
        _stateValid &&
        _streetValid &&
        _townValid) {
      String userId = auth.getUserId();

      userRef.doc(userId).update({
        "email": _email.text,
        "name": _name.text,
        "phone": _phone.text,
        "doorno": _doorno.text,
        "street": _street.text,
        "town": _town.text,
        "state": _state.text,
      });
      Fluttertoast.showToast(
        msg: "Profile Updated",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        elevation: 1.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const NavigationBar();
                },
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "Settings");
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 25.0, right: 16.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4.0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2.0,
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          ),
                        ],
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2016/12/19/21/36/woman-1919143_960_720.jpg'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          border: Border.all(
                            width: 4.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              buildTextField("Full Name", _name, _nameValid),
              buildTextField("Email", _email, _emailValid),
              buildTextField("Phone Number", _phone, _phoneValid),
              buildTextField("Door Number", _doorno, _doornoValid),
              buildTextField("Street", _street, _streetValid),
              buildTextField("Town/City", _town, _townValid),
              buildTextField("State", _state, _stateValid),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: updateUserProfile,
                    child: const Text(
                      'Update Profile',
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
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController controller, bool valid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0, left: 15.0, right: 15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 3.0),
          labelText: labelText,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorText: valid ? null : "Please fill this field",
        ),
      ),
    );
  }
}
