import 'package:flutter/material.dart';
import 'landing_page.dart';

class OpenIngPage extends StatefulWidget {
  const OpenIngPage({Key? key}) : super(key: key);

  @override
  State<OpenIngPage> createState() => _OpenIngPageState();
}

class _OpenIngPageState extends State<OpenIngPage> {
  List<String> words = ['Food Recipe'];
  String currentText = '';

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    for (int i = 0; i < words.length; i++) {
      for (int j = 0; j < words[i].length; j++) {
        Future.delayed(Duration(milliseconds: j * 500), () {
          if (mounted) {
            setState(() {
              currentText += words[i][j];
            });

            // Check if the animation is completed
            if (j == words[i].length - 1) {
              // Delay for a moment before navigating to LandingPage
              Future.delayed(Duration(seconds: 1), () {
                // Navigate to the LandingPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              });
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // LandingPage background
          LandingPageBackground(),

          // OpenIngPage content
          Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.grey, Colors.black], // Change the colors as needed
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                currentText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white, // Starting color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LandingPageBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey,
            ],
          ),
        ),
    );
  }
}
