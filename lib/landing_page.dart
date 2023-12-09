import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'signin_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  List<String> words = ['Food Recipe'];
  String currentText = '';
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  void _startTypingAnimation() {
    for (int i = 0; i < words.length; i++) {
      for (int j = 0; j < words[i].length; j++) {
        Future.delayed(Duration(milliseconds: j * 1000), () {
          if (mounted) {
            setState(() {
              currentText += words[i][j];
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = 0.2 * screenHeight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              // Your GIF goes here
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/recipe_logo.gif',
                  height: 0.35 * screenHeight, 
                ),
              ),
              Spacer(flex: 2),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.white, Colors.black], // Change the colors as needed
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Text(
                currentText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white, // Starting color
                ),
              ),
            ),
              ),
              Spacer(flex: 2),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                 
                  child: Text('Sign Up', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                   style: ElevatedButton.styleFrom(
                    fixedSize: Size(buttonWidth, 50.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(buttonWidth, 50.0),
                  ),
                  child: Text('Sign In', style: TextStyle(fontSize: 20.0,color: Colors.black)),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }
}

