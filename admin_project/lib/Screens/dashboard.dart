import 'package:admin_project/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Widget buildImageCard(String imageAddrs, String heading) => Card(
          color: const Color(0xffa8ce9a),
          elevation: 14.0,
          shadowColor: const Color(0x802196F3),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: AssetImage(imageAddrs),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, heading);
                  },
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Text(
                heading,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.green,
          ),
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
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          buildImageCard('assets/images/factory.png', "Add Factories"),
          buildImageCard('assets/images/delivery.png', "Deliveries"),
          buildImageCard('assets/images/transaction.png', "Transactions"),
        ],
        staggeredTiles: const [
          StaggeredTile.extent(2, 240.0),
          StaggeredTile.extent(1, 170.0),
          StaggeredTile.extent(1, 170.0),
        ],
      ),
    );
  }
}
