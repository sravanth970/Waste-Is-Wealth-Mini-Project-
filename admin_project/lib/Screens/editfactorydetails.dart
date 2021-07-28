import 'package:flutter/material.dart';

class EditFactoryDetails extends StatefulWidget {
  const EditFactoryDetails({Key? key}) : super(key: key);

  @override
  _EditFactoryDetailsState createState() => _EditFactoryDetailsState();
}

class _EditFactoryDetailsState extends State<EditFactoryDetails> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _organisation = TextEditingController();
    TextEditingController _street = TextEditingController();
    TextEditingController _doorno = TextEditingController();
    TextEditingController _town = TextEditingController();
    TextEditingController _state = TextEditingController();

    bool _organisationValid = true;
    bool _doornoValid = true;
    bool _townValid = true;
    bool _stateValid = true;
    bool _streetValid = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Edit Factories",
          style: TextStyle(
            color: Colors.green,
          ),
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
      body: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 25.0, right: 16.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                'Edit Factory',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              buildTextField("Organisation", _organisation, _organisationValid),
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
                    onPressed: () {},
                    child: const Text(
                      'Update',
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
