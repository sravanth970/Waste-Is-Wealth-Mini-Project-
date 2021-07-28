import 'package:admin_project/Screens/authentication.dart';
import 'package:admin_project/Screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin_project/Screens/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';

final adminRef = FirebaseFirestore.instance.collection("adminProfile");

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  void initState() {
    getAdminData();
    super.initState();
  }

  final auth = Authentication();

  final TextEditingController _organisation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _doorno = TextEditingController();
  final TextEditingController _town = TextEditingController();
  final TextEditingController _state = TextEditingController();

  bool _emailValid = true;
  bool _organisationValid = true;
  bool _phoneValid = true;
  bool _doornoValid = true;
  bool _townValid = true;
  bool _stateValid = true;
  bool _streetValid = true;

  void getAdminData() async {
    String adminId = auth.getAdminId();

    final DocumentSnapshot doc = await adminRef.doc(adminId).get();

    _email.text = doc['email'];
    _organisation.text = doc['organisation'];
    _phone.text = doc['phone'];
    _doorno.text = doc['doorno'];
    _street.text = doc['street'];
    _town.text = doc['town'];
    _state.text = doc['state'];
  }

  void updateAdminProfile() {
    // Checking for empty fields
    setState(() {
      _email.text.isEmpty ? _emailValid = false : _emailValid = true;
      _organisation.text.isEmpty
          ? _organisationValid = false
          : _organisationValid = true;
      _phone.text.isEmpty ? _phoneValid = false : _phoneValid = true;
      _doorno.text.isEmpty ? _doornoValid = false : _doornoValid = true;
      _street.text.isEmpty ? _streetValid = false : _streetValid = true;
      _state.text.isEmpty ? _stateValid = false : _stateValid = true;
      _town.text.isEmpty ? _townValid = false : _townValid = true;
    });

    // Updating the Profile of Admin
    if (_emailValid &&
        _organisationValid &&
        _phoneValid &&
        _doornoValid &&
        _stateValid &&
        _streetValid &&
        _townValid) {
      String adminId = auth.getAdminId();

      adminRef.doc(adminId).update({
        "email": _email.text,
        "organisation": _organisation.text,
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
                  return const Dashboard();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AdminSettings();
                  },
                ),
              );
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
                height: 35.0,
              ),
              buildTextField("Organisation", _organisation, _organisationValid),
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
                    onPressed: updateAdminProfile,
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
