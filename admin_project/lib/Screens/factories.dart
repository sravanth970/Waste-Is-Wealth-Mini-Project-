import 'package:admin_project/Screens/addfactorydetails.dart';
import 'package:flutter/material.dart';

class Factories extends StatefulWidget {
  const Factories({Key? key}) : super(key: key);

  @override
  _FactoriesState createState() => _FactoriesState();
}

class _FactoriesState extends State<Factories> {
  List<String> items = <String>[
    "Plastic",
    "Clothes",
    "Medical",
    "Electronic",
    "Paper",
    "Food",
    "Organic",
    "Others"
  ];

  List images = [
    "assets/images/plastic.png",
    "assets/images/clothes.png",
    "assets/images/medical.png",
    "assets/images/electronic.png",
    "assets/images/paper.png",
    "assets/images/food.png",
    "assets/images/organic.png",
    "assets/images/others.png"
  ];

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: 8,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              images[index],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            items[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const AddFactoryDetails(),
                                settings: RouteSettings(
                                  arguments: items[index],
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 14.0,
                              letterSpacing: 2.2,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
