import 'package:flutter/material.dart';
import 'signup_page.dart'; 
import 'signin_page.dart'; 
import 'ProfilePage.dart'; 
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = 0.2 * screenHeight; 

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            SizedBox(height: 0.8 * screenHeight), 
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(buttonWidth, 50.0), 
              ),
              child: Text('Sign Up', style: TextStyle(fontSize: 20.0)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(buttonWidth, 50.0),
              ),
              child: Text('Sign In', style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
}
