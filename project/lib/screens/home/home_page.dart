import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project/screens/categories.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project/screens/settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Widget buildImageCard(String imageAddrs, String heading) {
    //   return Card(
    //     color: const Color(0xffa8ce9a),
    //     elevation: 14.0,
    //     shadowColor: const Color(0x802196F3),
    //     clipBehavior: Clip.antiAlias,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(24),
    //     ),
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Ink.image(
    //           image: AssetImage(imageAddrs),
    //           child: InkWell(
    //             onTap: () {
    //               Navigator.pushNamed(context, "Orders", arguments: heading);
    //             },
    //           ),
    //           height: 240,
    //           fit: BoxFit.cover,
    //         ),
    //         Text(
    //           heading,
    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //             fontSize: 24,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Future<bool> _onBackPressed() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Do you want to exit the app?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1.0,
          title: const Text(
            'Home',
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
                      return const Settings();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      "Select your Category",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: AnimationLimiter(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      categories.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "Weights",
                              arguments: categories[index]);
                        },
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                          categories[index].imageAddrs),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.greenAccent,
                                        width: 4.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    categories[index].category,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// StaggeredGridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           children: [
//             buildImageCard('assets/images/plastic.png', 'Plastic'),
//             buildImageCard('assets/images/paper.png', 'Paper'),
//             buildImageCard('assets/images/electronic.png', 'Electronics'),
//             buildImageCard('assets/images/clothes.png', 'Clothes'),
//             buildImageCard('assets/images/food.png', 'Food'),
//             buildImageCard('assets/images/medical.png', 'Medical'),
//             buildImageCard('assets/images/organic.png', 'Organic'),
//             buildImageCard('assets/images/others.png', 'Others'),
//           ],
//           staggeredTiles: const [
//             StaggeredTile.extent(2, 240.0),
//             StaggeredTile.extent(1, 170.0),
//             StaggeredTile.extent(1, 170.0),
//             StaggeredTile.extent(2, 240.0),
//             StaggeredTile.extent(2, 240.0),
//             StaggeredTile.extent(1, 170.0),
//             StaggeredTile.extent(1, 170.0),
//             StaggeredTile.extent(2, 240.0),
//           ],
//         ),