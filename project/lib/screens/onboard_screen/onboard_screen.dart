import 'package:flutter/material.dart';
import 'package:project/Screens/Start/start.dart';

// This package is used to create OnBoard Screen for the application
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project/Screens/Widget/button_widget.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Adding Image to the Page
    Widget buildImage(String path) =>
        Center(child: Image.asset(path, width: 350));

    // Page Decoration Method
    PageDecoration getPageDecoration() => PageDecoration(
          titleTextStyle:
              const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyTextStyle: const TextStyle(fontSize: 20),
          descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
          imagePadding: const EdgeInsets.all(24),
          pageColor: Colors.white,
        );

    // Decoration for the Dots
    DotsDecorator getDotDecoration() => DotsDecorator(
          color: const Color(0xFFBDBDBD),
          //activeColor: Colors.orange,
          size: const Size(10, 10),
          activeSize: const Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          activeColor: Colors.green,
        );

    // Move to Start Page
    void goToStart(context) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Start()),
        );

    return SafeArea(
      // This class comes from the Introduction Screen Package
      child: IntroductionScreen(
        // Pages in OnBoard Screen
        pages: [
          // Page 1
          PageViewModel(
            title: "Collect the Garbage",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            image: buildImage("assets/images/Clean_Garbange.png"),
            decoration: getPageDecoration(),
          ),
          // Page 2
          PageViewModel(
            title: "Deliver the Package",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            image: buildImage("assets/images/Delivery.png"),
            decoration: getPageDecoration(),
          ),
          // Page 3
          PageViewModel(
            title: "Get Money",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            footer: ButtonWidget(
              text: 'Start Delivery',
              onClicked: () {
                goToStart(context);
              },
            ),
            image: buildImage("assets/images/Money_Transfer.png"),
            decoration: getPageDecoration(),
          ),
        ],
        done: const Text(
          "Deliver",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        // Method to perform when "Read" is clicked
        onDone: () {
          goToStart(context);
        },
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18.0,
          ),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.orange,
        ),
        dotsDecorator: getDotDecoration(),
        globalBackgroundColor: Colors.white,
        isProgressTap: false,
      ),
    );
  }
}
