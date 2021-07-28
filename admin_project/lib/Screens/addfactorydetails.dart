import 'package:admin_project/Screens/databasemanager.dart';
import 'package:admin_project/Screens/editfactorydetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFactoryDetails extends StatefulWidget {
  const AddFactoryDetails({Key? key}) : super(key: key);

  @override
  _AddFactoryDetailsState createState() => _AddFactoryDetailsState();
}

class _AddFactoryDetailsState extends State<AddFactoryDetails> {
  @override
  void initState() {
    super.initState();
  }

  final db = DatabaseManager();

  final edit = const EditFactoryDetails();

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments.toString();

    showAddDialog(BuildContext context) {
      TextEditingController _name = TextEditingController();
      TextEditingController _doorno = TextEditingController();
      TextEditingController _street = TextEditingController();
      TextEditingController _town = TextEditingController();
      TextEditingController _state = TextEditingController();

      List<String> details = [];

      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: const Center(
                child: Text("Add Factory"),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Factory Name",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _doorno,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Door No",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _street,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Street Name",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _town,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Town/City",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _state,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "State",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.green,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            details.add(_name.text);
                            details.add(_doorno.text);
                            details.add(_street.text);
                            details.add(_town.text);
                            details.add(_state.text);
                            db.addFactory(category, details);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    showEditDialog(BuildContext context, DocumentSnapshot doc, String docID) {
      TextEditingController _name = TextEditingController();
      TextEditingController _doorno = TextEditingController();
      TextEditingController _street = TextEditingController();
      TextEditingController _town = TextEditingController();
      TextEditingController _state = TextEditingController();

      _name.text = doc['name'];
      _doorno.text = doc['doorno'];
      _street.text = doc['street'];
      _town.text = doc['town'];
      _state.text = doc['state'];

      List<String> details = [];

      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: const Center(
                child: Text("Edit Factory"),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Factory Name",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _doorno,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Door No",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _street,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Street Name",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _town,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "Town/City",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextField(
                      controller: _state,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.0),
                        hintText: "State",
                        hintStyle:
                            TextStyle(color: Colors.green, fontSize: 18.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.green,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            details.add(_name.text);
                            details.add(_doorno.text);
                            details.add(_street.text);
                            details.add(_town.text);
                            details.add(_state.text);
                            db.editFactory(category, docID, details);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Factories",
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(category).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot factoryData = snapshot.data!.docs[index];
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Organisation: ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          factoryData['name'],
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          "Address: ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          factoryData['doorno'] + " ," + factoryData['street'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          factoryData['town'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          factoryData['state'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                              ),
                              onPressed: () {
                                showEditDialog(context, factoryData,
                                    snapshot.data!.docs[index].id);
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: 2.2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                              ),
                              onPressed: () {
                                db.deleteFactory(
                                    category, snapshot.data!.docs[index].id);
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  letterSpacing: 2.2,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        tooltip: "Add Factories",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
